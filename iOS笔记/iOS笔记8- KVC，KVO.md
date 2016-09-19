#KVC,KVO
主要分成一下几个部分  
1.KVC  
　　1.1 KVC简介  
　　1.2 KVC使用  
2.KVO  
	2.1 KVO简介
	2.2 KVO使用 

##KVC
###1.1  KVC简介
什么是KVC?

	KVC-> Key,Value,Coding，键值编码。
	通常我们调用方法或者访问实例属性的方式，得到或者修改属性值。
	KVC则是直接利用字符串描述对对象属性进行访问。

KVC的方法
	
	- (nullable id)valueForKey:(NSString *)key;   //直接通过Key来取值
	- (void)setValue:(nullable id)value forKey:(NSString *)key;   //通过Key来设值
	- (nullable id)valueForKeyPath:(NSString *)keyPath;   //通过KeyPath来取值
	- (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;  //通过KeyPath来设值
	
###1.2 KVC使用
1.访问对象属性(直接方法，通过关系式访问)
方法:
	
	直接访问
	- (nullable id)valueForKey:(NSString *)key;
	
	通过关系访问
	- (nullable id)valueForKeyPath:(NSString *)keyPath;
	例如:
	[person valueForKeyPath:@"address.city"];
	
	Person有一个address属性,address属性中有一个city属性。
	
	注意:valueForKeyPath:返回跟接受者相关的路径的值。
	如果路径里面没找到，就会调用valueForUndefineKey方法
	
2.访问私有成员变量
KVC还可以更改私有成员变量。利用KVC我们可以访问赋值一个对象的私有成员。  
	
>但是如果说这样,是不是就能去修改苹果里面的一些私有东西了?  

　　建议还是不要！！！在app上架前审核的过程中，苹果的官方会对这类做法严格检查，如果发现，苹果的审核时不能通过的。
　
##KVO
###2.1  KVO简介
什么是KVO？
	
	KVO是一个种观察者设计模式。比如:指定一个被观察对象(例如Person类)，当对象某个属性(例如Person中的字符串name)发生更改时，对象会获得通知，并作出相应处理；
	【且不需要给被观察的对象添加任何额外代码，就能使用KVO机制】

KVO基本原理:
	
	当观察对象A时，KVO会动态的创建一个对象A的当前类的子类，并且重写了新的子类的被观察属性keyPath的setter方法。setter方法随后负责通知观察对象属性改变的状况。
	
具体来讲:
	
	1.观察对象时，会动态创建一个新类:NSKVONotifying_A,并且A对象的isa指针指向新类。A对象就变成新类的对象了。
	2.重写了新类中观察的属性的setter方法。新的setter方法会负责在调用员setter方法之前和之后，通知所有观察对象属性值的更改情况。
	3.KVO的：KVO的键值观察通知依赖于 NSObject 的两个方法:willChangeValueForKey:和 didChangevlueForKey:，在存取数值的前后分别调用2个方法。
	
使用注意:

1.观察者观察的是属性。只有执行了setter方法，或者使用KVC赋值才会触发KVO机制。
比如给成员变量_name = @“Hayder” 就不会触发KVO机制。

###2.2  KVO使用
KVO使用步骤
>　　1.注册观察者，实时监听   
　　2.在回调方法中处理属性变化  
　　3.移除观察者

实现方法：
1.注册观察者:
	
	//第一个参数observer：观察者 （这里观察self.myKVO对象的属性变化）
	//第二个参数keyPath： 被观察的属性名称(这里观察self.myKVO中num属性值的改变)
	//第三个参数options： 观察属性的新值、旧值等的一些配置（枚举值，可以根据需要设置，例如这里可以使用两项）
	//第四个参数context： 上下文，可以为kvo的回调方法传值（例如设定为一个放置数据的字典）
	[A addObserver:self forKeyPath:@"name" options:
	NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
	
2.属性(keyPath)的值发生变化时，收到通知，调用一下方法.
	
	//keyPath:属性名称
	//object:被观察的对象
	//change:变化前后的值都存储在change字典中
	//context:注册观察者时，context传过来的值
	-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
	{
	
	}

