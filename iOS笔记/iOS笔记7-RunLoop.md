#RunLoop

主要分为几个内容:  
1. RunLoop基础  
　　1.1 RunLoop是什么;  
　　1.2 RunLoop是作用;   
　　1.3 RunLoop对象;    
　　1.4 RunLoop与线程;  
　　1.5 RunLoop模式;  
2. RunLoop组成   
　　2.1 RunLoop - timer;  
　　2.2 RunLoop - source;  
　　2.3 RunLoop - observe;  
3. RunLoop整体逻辑  
4. RunLoop实践  
　　4.1 ImageView显示;   
　　4.2 常驻线程  

##RunLoop基础
####1.1RunLoop是什么
> 从字面意思看就是运行循环，跑圈。  
> 其实它内部就是一个do-while循环，在这个循环内部不断的处理各种事件  
> 一个线程对应一个Runloop,主线程的RunLoop默认已经启动，子线程的Runloop需要自己启动  
> RunLoop智能选择一个Mode	启动，如果当前Mode没有任何Source,Timer,observer，那么就是直接退出RunLoop

####1.2RunLoop主要作用
>1.保持程序的持续运行  
>2.处理App中的各种事件(比如触摸时间、定时器实践、selector事件)  
>3.节省CPU资源，提高程序性能;该做事时做事，该休息时休息。  

main函数中的RunLoop
	
	int main(int argc, char * argv[]) {
	    @autoreleasepool {
	        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	    }
	}

1.在UIApplicationMain函数内部就启动了一个RunLoop  
2.所以UIApplicationMain函数一直没有返回，保持了程序的持续运行。  
3.这个默认启动的Runloop是跟主线程相关联的。	

####1.3RunLoopd对象
iOS中有2套API来访问和使用RunLoop  
1.Foundation 中 NSRunLoop  
2.Core Foundation 中 CFRunLoopRef	

NSRunLoop 和 CFRunLoopRef都代表着RunLoop对象。
NSRunLoop 是基于CFRunLoopRef的一层OC包装，所以要更深层次了解RunLoop内部结构，还是得使用CFRunLoopRef对象。

#####获得RunLoop对象

	//获取当前RunLoop
	[NSRunLoop currentRunLoop];
    
    CFRunLoopGetCurrent();
    
    //获取主线程RunLoop
    [NSRunLoop mainRunLoop];
    
    CFRunLoopGetMain();

####1.4RunLoop与线程
1.每条线程都有唯一的一个与之对应的RunLoop对象。  
2.主线程的RunLoop已经自动创建好了，子线程的RunLoop需要主动创建
3.RunLoop在第一次获取时创建，在线程结束时销毁。

注意:
在子线程中，RunLoop对象没有创建，并且不能通过alloc创建，RunLoop对象是懒加载，通过调用currentRunLoop来创建。

####1.5RunLoop模式
CFRunLoopModeRef代表RunLoop的运行模式
1.一个RunLoop包含若干个Mode,每个Mode又包含若干个Source/Timer/Observer  
2.每次RunLoop启动时，只能指定其中一个Mode,这个Mode被称作CurrentMode  
3.如果需要切换Mode,只能退出Loop.再重新制定一个Mode进入，这样做主要目的是为了分隔开不同组的Source/Timner/Observer，让其互不影响。

kCFRunLoopDefaultMode:app的默认mode,通常主线程就是在这个Mode下运行  
UITrackRunLoopMode:界面跟踪Mode,用scrollView追踪触摸华东，保证界面滑动时不受其他Mode影响。
NSRunLoopCommonModes:可以同时运行在kCFRunLoopDefaultMode和UITrackRunLoopMode模式下。


##RunLoop组成
当RunLoop进入某一个模式的时候，需要处理3大块的内容，timer,source,observe。
####2.1RunLoop - timer
Timer  就是平常用的定时器  NSTimer

创建定时器
方法1:  使用scheduledTimerWithTimeInterval 函数

	[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(run) userInfo:nil repeats:NO];
	调用了scheduledTimerWithTimeInterval返回的定时器，已经被添加到runloop中了NSDefaultRunLoopMode  

如果想修改模式，比如想在滑动的时候也调用定时器
	
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(run) userInfo:nil repeats:NO];
    
    //修改模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

方法2: 使用timerWithTimeInterval

	 NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //定时器只运行在NSDefaultRunLoopMode下，一旦runloop进入其他模式，这个定时器就不会工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

####2.2RunLoop - source
>source，事件源，输入源。比如一些触摸事件等。一般由系统决定。

#####实践分类:
source0 : 非基于Port的。不是其他线程，内核发布消息。  
source1: 基于Port的，通过内核和其他线程通信，接收，分发系统事件。 

####2.3RunLoop - observe
observe 用来监听RunLoop的状态。
监听的时间点有以下几个:  
>typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {  
　　kCFRunLoopEntry = (1UL << 0), //即将进入runloop  1  
　　kCFRunLoopBeforeTimers = (1UL << 1), //即将处理timer 2  
　　kCFRunLoopBeforeSources = (1UL << 2),//即将处理source 4  
　　kCFRunLoopBeforeWaiting = (1UL << 5),//即将进入休眠 32  
　　kCFRunLoopAfterWaiting = (1UL << 6),//刚从休眠中醒来 64  
　　kCFRunLoopExit = (1UL << 7),//即将退出runloop 128  
　　kCFRunLoopAllActivities = 0x0FFFFFFFU //上面所有状态  
};

给当前的runloop添加一个观察者，拦截一些事件
	
    //创建一个observe
    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSLog(@"%zd",activity);
    });
    
    //添加观察者：监听RunLoop的状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observe, kCFRunLoopDefaultMode);
    
    //释放observe
    CFRelease(observe);

补充：CF框架的内存管理  

	/**
		*CF的内存管理(core Foundation)
		 1.凡是带有create,copy,retain等字眼的函数，创建出来的对象，都需要在最后做一次release
		  *比如CFRunLoopObserveCreate
	 
		 2.release函数
		 CFRelease(对象);
	*/
##3. RunLoop整体逻辑  
##4. RunLoop实践 
####4.1 ImageView显示
#####scrollview滚动的时候加载图片出现卡顿的情况,需要延迟显示，可以利用runloop进行延迟加载

	[imageview performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"1"] afterDelay:0.3 inModes:@[NSDefaultRunLoopMode]];
	
####4.2 常驻线程  
#####常驻线程:希望线程一直永远不死，一直在后台运行,避免多次创建线程销毁。比如:在子线程中开启一个定时器，在子线程中进行一些长期监控。
	
	@interface ViewController ()

	@property (nonatomic, strong) NSThread *thread;

	@end

	@implementation ViewController
步骤1: 创建子线程

	- (void)viewDidLoad {
    [super viewDidLoad];

		//创建一个线程并且启动
	    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
	    
	    [self.thread start];
	}
步骤2: 创建runloop
	
	- (void)run
	{
	    //在创建了线程以后创建RunLoop。
	    //原因:开启子线程后，执行完任务，子线程就会死亡，通过创建runloop可以使子线程常驻。就像主线程一样。
		//runloop中Mode如果没有source,observe,timer,runloop就会退出。首先先创建一个port(相当于source),第二步运行runloop。
	    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
	    [[NSRunLoop currentRunLoop] run];
	}
步骤3: 测试常驻线程

	- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
	{
	    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
	}

	- (void)test
	{
	    NSLog(@"%@----thread",[NSThread currentThread]);
	    NSLog(@"test");
	}
  