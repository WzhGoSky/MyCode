#Runtime
####本章笔记总共分为以下几个部分:  

1 Runtime基础  <runtime1,2,3>  
　　1.1 Class, Meta Class,objc_object与id  
　　1.2 methodLists 和 cache  
　　1.3 SEL, IMP, Method   
　　1.4 调用方法时大致流程 <装逼指南>  

2.成员变量和属性 <三分钟>  
　　2.1 成员变量和属性到底是什么  
　　2.2 通过runtime获取属性和成员变量  
　　2.3 变量和属性的区别  

3.消息机制  

4.Runtime具体使用场景

##1.Runtime基础
###1.1 Class, Meta Class,objc_object与id

#####Class 在OC中定义其实是一个结构体指针类型
	
	typedef struct objc_class *Class;

objc_class 结构体内部
	
	struct objc_class {
	
	    Class isa  OBJC_ISA_AVAILABILITY;
	
		#if !__OBJC2__
	    Class super_class                                        OBJC2_UNAVAILABLE;
	    const char *name                                         OBJC2_UNAVAILABLE;
	    long version                                             OBJC2_UNAVAILABLE;
	    long info                                                OBJC2_UNAVAILABLE;
	    long instance_size                                       OBJC2_UNAVAILABLE;
	    struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
	    struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
	    struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
	    struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
		#endif

	} OBJC2_UNAVAILABLE;

		其中Class中也有一个isa指针，指向其所属的元类(meta).
		super_class: 指向其父类。
		name: 类名
		version: 类的版本信息 默认为0
		info: 类的详情
		instance_size: 该类的实例对象的大小
		ivars: 指向该类的成员变量列表
		methodLists: 指向该类的实例方法列表。它将方法选择器(SEL)和方法实现地址联系起来了。
		methodLists: 是指向objc_method_list 指针的指针(指向 methodlist,方法列表的地址)，可以动态的修改*methodlist的值来添加成员方法,也是Category实现的原理.同样也解释了Category不能添加属性的原因。
		cache: Runtime 系统会把被调用到的方法存到cache中(一个方法如果被调用，那么它有可能以后还会被调用),为了下次查找的时候更加的高效。
		protocols: 指向该类的协议列表。
	
OC中任何一个类都是用objc_class这样一个结构体来描述的。

#####meta Class(元类)
>　　一个class实例化成instance,instance中会有一个isa指针指向class。class也是一个对象，称为类对象,它的isa指针指向哪？  
　　为了解决这个问题:runtime 创造了元类(Meta Class)。当我们向一个类发送消息的时候，isa指针会在元类中以及元类的父类方法列表寻找对应的方法执行。

那meta Class的元类又该指向哪边？  
![images](https://github.com/WzhGoSky/NoteImages/blob/master/iOS%E7%AC%94%E8%AE%B06-Runtime/1.png)

从图中我们可以知道以下几点:  
　　1.任何一个元类都是根元类的对象。  
　　2.任何一个元类的isa指针都指向了根元类。  
　　3.根元类的父类是NSOject,而根元类的isa指针又指向了它自己。 NSObject的超类为nil,而isa指向自己。

#####objc_object与id

id在OC定义中是一个objc_object结构体类型的指针

	typedef struct objc_object *id;
	
objc_object 内部
	
	struct objc_object{
		
		Class isa OBJC_ISA_AVAILABLEITY;
	};

对象的内部就是这样子，包含一个指向类对象的isa指针，对象可以通过isa指针找到其所属的类。然后在类的方法列表以及父类的方法列表中寻找对应的方法运行。
id是一个objc_object结构类型的指针，这个类型的对象可以转换成任何一种对象。

##1.2 methodLists 和 cache 
#####methodLists

OC中，定义类的结构体里面有一个methodLists,这是一个二级指针,一个指向指针的指针，即指针变量中存的是一个地址。

	 struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
	 
methodLists表示方法列表，一个指向结构体objc_method_list的二级指针，可以动态的修改*methodList的值来添加方法，这就是Category的原理。

具体先看objc_method_list
	
	struct objc_method_list {

		struct objc_method_list *obsolete                   OBJC2_UNAVAILABLE;
	
		int method_count                                    OBJC2_UNAVAILABLE;
	
		#ifdef __LP64__
		int space                                           OBJC2_UNAVAILABLE;
	
		#endif
	
		/* variable length structure */
	
		struct objc_method method_list[1]                   OBJC2_UNAVAILABLE;

	}

objc_method_list 是一个链表，存储多个objc_method，而objc_method结构体存储类的某个方法的信息。

#####cache

cache用来缓存方法，当调用方法时，优先在cache中查找，如果没有找到,再到methodList查找。

	struct objc_cache *cache                                                  OBJC2_UNAVAILABLE;

	structobjc_cache {
		
		unsigned int mask/* total = mask + 1 */                OBJC2_UNAVAILABLE;
	   
	    unsigned int occupied                                  OBJC2_UNAVAILABLE;

		Method buckets[1]                                      OBJC2_UNAVAILABLE;

	};

cache必要性:  
　　为什么搞一个这个东西出来，为什么不直接在类的methodLists直接搜索呢？  
　　原因是那样效率太低了，一个类经常被调用的方法大概只有20%，会占到总调用次数的80%。所以缓存就很有必要了，cache用来缓存经常访问的方法，会很高提升查找到方法的效率。

###1.3 SEL, IMP, Method

#####SEL
SEL是selector在Objct-C中的表示类型。selector可以理解为区别方法的ID。
SEL就是对方法的一种包装。包装的SEL类型数据它对应相应的方法地址，找到方法地址就可以调用方法。
	
	typedefstructobjc_selector *SEL;

objc_selector的定义如下:
	
	struct objc_selector {

		char *name;                      OBJC2_UNAVAILABLE;// 名称

		char *types;                      OBJC2_UNAVAILABLE;// 类型

	};

通过SEL可以迅速的定位到IMP。


