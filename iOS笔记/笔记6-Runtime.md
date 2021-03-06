#Runtime
####本章笔记总共分为以下几个部分:  

1 Runtime基础  
　　1.1 Class, Meta Class,objc_object与id  
　　1.2 methodLists 和 cache  
　　1.3 SEL, IMP, Method   
　　1.4 调用方法时大致流程  
　　1.5 objc_msgSendSuper

2.成员变量和属性   
　　2.1 成员变量和属性定义  
　　2.2 通过runtime获取属性和成员变量  
　　2.3 应用场景  

3.消息机制  
　　3.1 消息机制介绍  
　　3.2 NSProxy   

4.Runtime具体使用场景  
　　4.1 设置分类属性  
　　4.2 交换方法
　　
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
	
	typedef struct objc_selector *SEL;

objc_selector的定义如下:
	
	struct objc_selector {

		char *name;                      OBJC2_UNAVAILABLE;// 名称

		char *types;                      OBJC2_UNAVAILABLE;// 类型

	};

通过SEL可以迅速的定位到IMP。

####IMP
在objc.h中IMP有如下定义:
	
	typedef id (*IMP)(id, SEL,...);
	
IMP是“implementation”的缩写，它是一个有编译器生成的一个函数指针。这个函数指针决定了最终执行哪段代码。

####Method
Method的定义:
	
	typedef struct objc_method *Method;
	
objc_method的定义如下:
	
	struct obj_method{
		
		SEL method_name       OBJC2_UNAVAILABLE;//方法名
		
		char *method_types    OBJC2_UNAVAILABLE;//方法类型；
		
		method_imp            OBJC2_UNAVAILABLE;//方法实现 IMP类型
	}
	
在method中 method_name,method_imp, method_types三者的关系。SEL是一个key，IMP为一个value，而Method可以想成key到value的映射方法。这样就可以通过SEL迅速的定位到IMP。

###1.4 调用方法时大致流程
关于消息发送的runtime函数 objc_msgSend原型
	
	OBJC_EXPORT void objc_msgSend(void /* id self, SEL op, ... */ )
	
	
1.Runtime系统会把方法调用转换为消息发送，即objc_msgSend,并且把方法的调用者和方法选择器当做参数传递过去。
2.方法的调用者会通过isa指针找到其所属的类，然后在cache或者mothodLists中查找该方法。如果找到了该方法就执行，如果找不到该方法就通过super_class往上一级的超类查找。如果一直找到NSObject都没有找到该方法的话，就会进行消息转发。

###1.5 objc_msgSendSuper

当[super selector]调用时，就不是转换为objc_msgSend函数了，而是转换为objc_msgSendSuper

	OBJC_EXPORT void objc_msgSendSuper(void /* struct objc_super *super, SEL op, ... */ )

super是一个objc_super结构体指针，objc_super结构体定义如下
	
	struct objc_super {
	 
	    __unsafe_unretained id receiver;
	
	    __unsafe_unretained Class super_class;
	};
	
	参数1 receiver 类似objc_msg的第一个参数receiver,第二个成员记录写super这个类的父类是什么。

如以下例子:

	@implementation Son : Father
	- (id)init
	{
	    self = [super init];
	    if (self)
	    {
	        NSLog(@"%@", NSStringFromClass([self class]));
	        NSLog(@"%@", NSStringFromClass([super class]));
	    }
	    return self;
	}
	@end
	
	打印结果:都是“Son”

[super class] 调用时开始做了这几个事情  
　　1.构建objc_super,此时结构体的第一个参数receiver 就是self(Son对象),第二个成员变量super_class就是Son类的父类Father。  
　　2.调用objc_msgSenfSuper的方法，将构造的objc_super结构体和 class的sel传递过去。从objc_super结构体指向的superClass的方法列表开始找class的selector,找到以后再已objc_super->receiver去调用这个selector,可能也会使用objc_msgSend这个函数，不过此时的第一个参数就是objc_receiver，第二个参数就是从objc_super->super_class中吵到的selector。  
　　
#####关于[super init],为什么要调用self = [super init];
符合oc 继承类 初始化规范 super 同样也是这样，[super init]  去self 的super 中调用init,super 调用 superSuper 的init 。直到根类 NSObject 中的init ,

根类中init 负责初始化内存区域  向里面添加一些必要的属性，返回内存指针,这样 延着继承链 初始化的内存指针 被从上 到 下 传递，在不同的子类中向块内存添加子类必要的属性，直到 我们的 A类 中得到内存指针，赋值给slef 参数， 在if (slef){//添加A 的属性 }

##2.成员变量和属性
###2.1 成员变量和属性定义
####成员变量
成员变量定义：
	
	Ivar:实例变量类型，是一个指向objc_ivar结构体的指针。
	typedef struct objc_ivar *Ivar;

成员变量用到的函数
	
	class_copyIvarList   //获取类中所有的成员变量 返回值 Ivar * 
	class_getInstanceVariable  //获取类中指定名称的成员变量 返回值 Ivar
	
	ivar_getName  //获取成员变量名   返回值 const char *
	ivar_getTypeEncoding //获取成员变量类型编码 返回值const char *
	
	object_getIvar     // 获取某个对象成员变量的值 返回值 id
	object_setIvar     //设置某个对象成员变量的值  无返回值
	
####成员属性
成员属性定义:  
　　objc_property_t: 声明属性的类型，是一个指向objc_property结构体的指针。
	
	typedef struct objc_property *objc_property_t;
	
成员属性相关函数
	
	class_copyPropertyList    //获取所有属性 说明:并不会获取无@property声明的成员变量
	
	property_name         //获取成员属性名
	
	property_copyAttributeList //获取所有属性特性
	
	property_getAttributes //获取成员属性特性描述字符串

###2.2 通过runtime获取属性和成员变量 

	#import "Person.h"
	
	@interface Person : NSObject
	{
    	NSString *_ID;
	}

	@property (nonatomic, strong) NSString *name;

	@property (nonatomic, assign) NSInteger age;

	----------------------------------------------
	成员变量：
	-----------------------------------------------
	Person *p = [[Person alloc] init];
    
    //1.获取名为“_name”的成员变量
    Ivar ivar = class_getInstanceVariable([Person class], "_name");
    
    //2.设置值
    object_setIvar(p, ivar, @"Hayder");
   
    NSLog(@"%@",object_getIvar(p, ivar));
    
    打印结果:Hayder;
    
    -----------------------------------------------
    获取成员变量:
    -----------------------------------------------
    
    Ivar *ivars = class_copyIvarList([Person class], &number);
    
    for (unsigned int i=0; i < number; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        
        NSLog(@"name---%s,type-----%s",name,type);
    }
    
    free(ivars);
    
	打印结果:
	name---_ID,type-----@"NSString"
	name---_name,type-----@"NSString"
	name---_age,type-----q
	
	-----------------------------------------------
	成员属性:
	-----------------------------------------------
	unsigned int number = 0;
    
    objc_property_t *propertys = class_copyPropertyList([Person class], &number);
    
    for (unsigned int i=0; i < number; i++) {
        
        objc_property_t property = propertys[i];
        
        //字典转模型里面的key value就是dict[key]
        const char *name = property_getName(property);        
        const char *attribute = property_getAttributes(property);
        
        NSLog(@"name---%s,type-----%s",name,type);
    }
    
    free(propertys);
    
    打印结果:
    name---name, attribute-----T@"NSString",&,N,V_name
	name---age, attribute-----Tq,N,V_age
	
#####property_getAttribute属性说明
	
	property_getAttributes函数返回objc_property_attribute_t结构体列表，objc_property_attribute_t结构体包含name和value，常用的属性如下：

	属性类型  name值：T  value：变化
	编码类型  name值：C(copy) &(strong) W(weak)空(assign) 等 value：无
	非/原子性 name值：空(atomic) N(Nonatomic)  value：无
	变量名称  name值：V  value：变化

	使用property_getAttributes获得的描述是property_copyAttributeList能获取到的所有的name和value的总体描述，如 T@"NSString",&,N,V_name 
	
	@property (nonatomic, strong) NSString *name;

 	
#####小结:class_copyIvarList 包含成员变量+属性 class_copyPropertyList只包含成员变量

###2.3 应用场景
#####快速归档
在model中实现
	
	- (id)initWithCoder:(NSCoder *)aDecoder {
	
	    if (self = [super init]) {
	    
	        unsigned int outCount;
	        Ivar * ivars = class_copyIvarList([self class], &outCount);
	        for (int i = 0; i < outCount; i ++) {
	            Ivar ivar = ivars[i];
	            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
	            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
	        }
	    }
	    	return self;
	}
	
	- (void)encodeWithCoder:(NSCoder *)aCoder {
	    unsigned int outCount;
	    Ivar * ivars = class_copyIvarList([self class], &outCount);
	    for (int i = 0; i < outCount; i ++) {
	        Ivar ivar = ivars[i];
	        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
	        [aCoder encodeObject:[self valueForKey:key] forKey:key];
	    }
	}
#####访问私有变量
>OC中没有真正意义上面的私有变量和方法，要让成员变量私有，就要放在.m中声明，不要对外暴露。如果我们知道这个成员变量的名称，就可以同过runtime获取成员变量，再通过getIvar来获取它的值。

方法:

	Ivar ivar = class_getInstanceVariable([Model class], "_str1");
	NSString * str1 = object_getIvar(model, ivar);
 
 
##3.消息机制
###3.1消息机制介绍
在前面说到，如果向某个对象发消息，从对象的isa指针指向的类中寻找没有找到，到super_class中寻找,如果一直找到NSObject都没有找到，就会进行消息转发。如图:  
![images](https://github.com/WzhGoSky/NoteImages/blob/master/iOS%E7%AC%94%E8%AE%B06-Runtime/2.jpg)

#####1.对象在收到无法解读的消息后，首先会调用所属类
	
	+（BOOL）resolveInstanceMethod:(SEL)sel
	
在这个方法在运行时，没有找到SEL的IMP时就会执行。如果实现了添加函数代码返回YES，未实现返回NO。

	- (void)viewDidLoad {
    	[super viewDidLoad];
    
    	[self performSelector:@selector(doSomething)];
    
	}

	+ (BOOL)resolveInstanceMethod:(SEL)sel
	{
	    if (sel == @selector(doSomething)) {
	        
	        //add code here
	        NSLog(@"do something");
	        
	        return YES;
	    }
	    
	    return [super resolveInstanceMethod:sel];
	}

代码中执行@selector(doSomething)方法，但是并没有实现，会首先执行resolveInstanceMethod。

######应用场景:动态添加方法。

实现了resolveInstanceMethod 方法还是会崩溃，需要在打印的地方做一些操作，使这个方法得到响应，不至于走到 - (void)doesNotRecognizeSelector:(SEL)aSelector 这个方法中崩溃。

	- (void)viewDidLoad {
	
	    [super viewDidLoad];
	    
	    [self performSelector:@selector(doSomething)];
    
	}

	+ (BOOL)resolveInstanceMethod:(SEL)sel
	{
	    if (sel == @selector(doSomething)) {
	    
	        class_addMethod([self class], sel, (IMP)addMethod, "v@:");
	        
	        return YES;
	    }
	    
	    return [super resolveInstanceMethod:sel];
	}

	void addMethod(id self, SEL _cmd)
	{
		NSLog(@"添加方法");
	}

关于class_addMethod方法:
	
	OBJC_EXPORT BOOL class_addMethod(Class cls, SEL name, IMP imp,  const char *types)
	
	其中:
	cls :在哪个类中添加方法，也就是方法所添加的类
	name :方法名，这个随便起
	imp :实现这个方法的函数
	types :定义改书返回值类型和参数类型的字符串。
	
	比如: v就是void,代表返回类型就是空，@代表参数,这里指的是id(self),这里:指的是方法SEL(_cmd)。
	
	比如：
	int Method (id self, SEL _cmd, NSString *str) {

		  return 100;
	}
	
	此时添加这个函数的方法就应该是
	class_addMethod([self class],@selector(Method),(IMP)Method,@"i@:@");

#####2.如果在+ (BOOL)resolveInstanceMethod:(SEL)sel中没有找到或者添加方法，消息就会传递到- (id)forwardingTargetForSelector:(SEL)aSelector方法。

	- (id)forwardingTargetForSelector:(SEL)aSelector;
	这个方法返回的是可以执行aSelector的对象。
	
比如:
	
	#import "ViewController.h"
	#import <objc/runtime.h>
	
	@interface ViewController ()

	@end

	@implementation ViewController

	- (void)viewDidLoad {
	    [super viewDidLoad];
	    
	    [self performSelector:@selector(secondVCMethod)];
	}
	
	//第一步转发
	+ (BOOL)resolveInstanceMethod:(SEL)sel {

    	return [super resolveInstanceMethod:sel];
	}
	
	//第二步转发
	- (id)forwardingTargetForSelector:(SEL)aSelector {
	
	    Class class = NSClassFromString(@"ViewController2");
	    UIViewController *vc = class.new;
	    if (aSelector == NSSelectorFromString(@"secondVCMethod")) {
	        NSLog(@"secondVC do this !");
	        return vc;
	    }
	
	    	return nil;
		}
	
	@end

	执行secondVCMethod,并没有实现这个方法。于是消息转发给+(BOOL)resolveInstanceMethod:(SEL)sel,但是第一步转发的消息并没有执行，于是转发给第二步,在这个方法里面创建了一个ViewController2对象,并判断这个方法为secondVCMethod方法时，就返回ViewController2对象。通过forwardingTargetForSelector这个方法就把消息传递给了secondVCMethod。

#####3.如果不实现forwardingTargetForSelector,系统就会调用methodSignatureForSelector和forwardInvocation这两个方法。

1.methodSignatureForSelector用来生成方法签名
2.forwardInvocation中的参数NSInvocation使用生成的签名。

	- (void)viewDidLoad {
	    [super viewDidLoad];
	     
	    [self performSelector:@selector(run)];
	}

	- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
	{
	    //1.先转成字符串
	    NSString *sel = NSStringFromSelector(aSelector);
	    
	    if ([sel isEqualToString:@"run"]) {
	        
	        //如果是则签名，返回类类型 v->void @ -> id(self) :-> SEL _cmd
	        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
	    }
	    return [super methodSignatureForSelector:aSelector];
	}

	- (void)forwardInvocation:(NSInvocation *)anInvocation
	{
		SEL selector = [anInvocation selector];
	    
	    Person *person = [[Person alloc] init];
	    
	    //如果person实现了这个方法则执行这个方法
	    if ([person respondsToSelector:selector]) {
	        
	        //执行run这个方法
	        [anInvocation invokeWithTarget:person];
    	}
    
	}

###3.2 NSProxy
NSProxy这个类干嘛用的?  
>NSProxy 负责将消息转发到真正的target的代理类。 作用:OC只支持单继承 NSPorxy可模拟多继承

如何理解NSProxy这个类进行多继承
>假设类A，类B，类C中各有一个方法类D需要使用，但是OC又是单继承，可以利用NSPorxy作为代理，类D去向NSPorxy类中调用。
类D是顾客  NSPorxy是经销商 类A，类B，类C是供应商.

需要实现什么方法？
>- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel;
- (void)forwardInvocation:(NSInvocation *)anInvocation;

[Demo](https://github.com/WzhGoSky/MyCode/tree/master/Demo/NSProxy)


##4.Runtime具体使用场景  
###4.1 设置分类属性  
	@implementation ViewController

	- (void)viewDidLoad {
	    [super viewDidLoad];
	    // Do any additional setup after loading the view, typically from a nib.
	
	    // 给系统NSObject类动态添加属性name
	
	    NSObject *objc = [[NSObject alloc] init];
	    objc.name = @"Hayder";
	    NSLog(@"%@",objc.name);

	}


	@end


	// 定义关联的key
	static const char *key = "name";

	@implementation NSObject (Property)

	- (NSString *)name
	{
	    // 根据关联的key，获取关联的值。
	    return objc_getAssociatedObject(self, key);
	}

	- (void)setName:(NSString *)name
	{
	    // 第一个参数：给哪个对象添加关联
	    // 第二个参数：关联的key，通过这个key获取
	    // 第三个参数：关联的value
	    // 第四个参数:关联的策略
	    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

@end
###4.2 交换方法
	@implementation ViewController


	- (void)viewDidLoad {
	    [super viewDidLoad];
	    // Do any additional setup after loading the view, typically from a nib.
	    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
	    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
	    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
	    UIImage *image = [UIImage imageNamed:@"123"];

	}

	@end


	@implementation UIImage (Image)
	// 加载分类到内存的时候调用
	+ (void)load
	{
	    // 交换方法
	
	    // 获取imageWithName方法地址
	    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
	
	    // 获取imageWithName方法地址
	    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
	
	    // 交换方法地址，相当于交换实现方式
	    method_exchangeImplementations(imageWithName, imageName);
	

	}

	// 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

	// 既能加载图片又能打印
	+ (instancetype)imageWithName:(NSString *)name
	{

	    // 这里调用imageWithName，相当于调用imageName
	    UIImage *image = [self imageWithName:name];
	
	    if (image == nil) {
	        NSLog(@"加载空的图片");
	    }
	
	    return image;
	}


	@end



