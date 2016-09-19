//
//  ViewController.m
//  RunLoop
//
//  Created by Hayder on 16/9/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    [self timer];
    
//    UIImageView *imageview = [[UIImageView alloc] init];

//    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    
//    [self.thread start];
    
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //创建一个定时器(dispatch_source_t本质是一个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性(几时开始任务，每个多长时间执行一次)
    //GCD的时间参数，一般是纳秒(1秒 == 10的9次方纳秒)
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);//何时开始第一个任务
    dispatch_time_t interval = 2.0 * NSEC_PER_SEC; //何时开始重复任务
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
       
        NSLog(@"-------%@",[NSThread currentThread]);
    });
    
    dispatch_resume(self.timer);
    
}

- (void)timer1
{
    //调用了scheduledTimerWithTimeInterval返回的定时器，已经被添加到runloop中了NSDefaultRunLoopMode
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(run) userInfo:nil repeats:NO];
    
    //修改模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

////    //等价于
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
//    
//    //定时器只运行在NSDefaultRunLoopMode下，一旦runloop进入其他模式，这个定时器就不会工作
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    
//    //定时器会跑在标记为common modes的模式下
//    //标记为common modes的模式：NSDefaultRunLoopMode 和 UITrackRunLoopMode
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
   
}

- (void)observe
{
    //创建一个observe
    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSLog(@"%zd",activity);
    });
    
    //添加观察者：监听RunLoop的状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observe, kCFRunLoopDefaultMode);
    
    //释放observe
    CFRelease(observe);
}

- (void)run
{
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)test
{
    NSLog(@"%@----thread",[NSThread currentThread]);
    NSLog(@"test");
}
/**
 *  CF的内存管理(core Foundation)
 1.凡是带有create,copy,retain等字眼的函数，创建出来的对象，都需要在最后做一次release
  *比如CFRunLoopObserveCreate
 
 2.release函数
 CFRelease(对象);
 */


@end
