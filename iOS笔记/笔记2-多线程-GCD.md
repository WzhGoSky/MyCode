#GCD
##1.GCD基本概念  
####GCD2个核心的概念
	任务：执行什么操作
	队列：用来存放任务

####GCD使用
	(1)定制任务
	(2)确定想做的事情
	
	将任务添加到队列中，GCD会自动的将队列中的任务取出，放到对应的线程中执行
	注意：任务的取出遵循先进先出，后进后出的原则。

####GCD执行任务函数
	(1)同步方式执行任务 
	dispatch_sync(dispatch_queue_t queue, dispatch_block_t block);
	参数说明:queue: 队列
			block: 任务
	理解: 把右边的任务(block)放到左边的队列(queue)中执行
	
	(2)异步方式执行任务
	dispatch_async(dispatch_queue_t queue, dispatch_block_t block);
	
####同步，异步的区别
	同步:在当前线程中执行
	异步:在另一条线程中执行
	
####串行，并发的区别
	串行:一个任务执行完毕后，再执行下一个任务
	并发:多个任务并发同时执行
	
	1.获取串行队列
	方式1：使用dispatch_queue_create创建串行队列
	dispatch_queue_t queue =  dispatch_queue_create("laowang", NULL);
	
	方式2：使用主队列 (和主线程相关的队列)
	主队列是GCD自带的一种特殊的串行队列,放在主队列中的任务，都会放在主线程中执行
	dispatch_queue_t queue = dispatch_get_main_queue();
	
	2.获取并发队列
	方式1:使用dispatch_queue_create创建并发队列
	dispatch_queue_t queue = dispatch_queue_create(“laowang”,
    DISPATCH_QUEUE_CONCURRENT);
    
	方式2:GCD默认提供全局并发队列，供整个应用使用，不需要手动创建
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
####各种队列执行效果
	串行队列为使用dispatch_queue_create 创建的串行队列
	
	异步并发：
	开启新的线程，并发执行
	
	异步串行：
	开启新的线程，串行执行
	
	同步并发：
	不开启新的线程，串行执行任务
	
	同步串行：
	不开启新的线程，串行执行任务

#####队列，任务总结
	1.同步函数不具备开启线程的能力，无论什么队列都不会开始线程。
	2.异步函数具备开启线程的能力，开启线程的条数由队列决定。（串行队列为1条，并行队列为多条）
	
	异步函数具备开线程的能力，但是不一定会开启线程。
	
##2.dispatch_group(调度组)

>调度组最重要的目的,监听一组任务完成
	
	如果想在dispatch_queue中所有的任务执行完成后在做某种操作，在串行队列中，可以把该操作放到最后一个任务执行完成后继续，但是在并行队列中怎么做呢。这就有dispatch_group 成组操作。
###dispatch_group 使用函数

####1.dispatch_group_async
	dispatch_group_async(dispatch_group_t group, dispatch_queue_t queue,dispatch_block_t block);
	将任务（block）放入队列queue,然后和调度组group关联
	
	dispatch_queue_t dispatchQueue = dispatch_queue_create("laowang", DISPATCH_QUEUE_CONCURRENT);
	dispatch_group_t dispatchGroup = dispatch_group_create();
	dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
    NSLog(@"dispatch-1");
	});
	dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
    NSLog(@"dspatch-2");
	});
	dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
	    NSLog(@"end");
	});
	
	上面的 log1 和log2输出顺序不定，因为是在并发队列上执行，当并发队列全部执行完成后，最后到main队列上执行一个操作，保证“end”是最后输出。
	
####2.dispatch_group_enter(group)   dispatch_group_leave(group)
	标志着一个block(任务)被加入了group。
	
	dispatch_group_enter:增加当前group执行block数
	dispatch_group_leave:减少当前group执行block数
	
	调用dispatch_group_enter,dispatch_group_leave 可以非常适合处理异步任务同步(当有多个异步请求时，需要等待异步请求都结束时做些事情)，当异步任务开始前调用dispatch_group_enter，异步任务结束后调用dispatch_group_leave
	
	例:
	dispatch_group_t group = dispatch_group_create();
	
	//1.任务开始调用enter
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        NSLog(@"任务一完成");
        
        //2.任务结束调用leave
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务二完成");
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务完成");
    });
	
###注意
	假如我们不想使用dispatch_group_async异步的将任务丢到group中去执行，这时候就需要用到dispatch_group_enter跟dispatch_group_leave方法，这两个方法要配对出现，以下这两种方法是等价的：

	dispatch_group_async(group, queue, ^{ 
	
		任务
	});
	
	等价于:
	
	dispatch_group_enter(group);
	
	dispatch_async(queue, ^{
	
		//任务
		dispatch_group_leave(group);
	
	});
3种情况:  
  1.调度组没有任务，直接执行notify  
  2.调度组入组多余出组，notify永远不会执行，因为组永远不会为空   
  3.出租多余入组，会奔溃  

####3.dispatch_group_notify
	void dispatch_group_notify(dispatch_group_t group,dispatch_queue_t queue,
	dispatch_block_t block);
	当group上所有的任务被执行完毕以后，就会调用 dispatch_group_notify
	
####4.dispatch_group_wait
	dispatch_group_wait会同步地等待group中所有的block执行完毕后才继续执行,类似于dispatch barrier
    
####应用场景
	场景1：
	  某个页面加载时通过网络请求获得相应的数据，有的时候加载的内容需要通过好几个接口的数据组合而成，比如2个请求A和B，通常将B请求放在A请求成功回调中发起，在B的成功回调中组合起来。
	  
	  会产生的问题：
	  1.请求多了，要写多层的嵌套。
	  2.如果在除了最后一个请求前的某个请求失败了，不会执行后面的请求。
	  3.请求变成同步的，网络差的情况下，如果有n个请求，以为着用户要等待n倍于并发请求的时间才能看到内容。
	  
	  假设要上传4张图片
	NSMutableArray *imageURLs= [NSMutableArray array];
	
	//1.创建dispatch_group任务组
	dispatch_group_t group =dispatch_group_create();              
	
	for (UIImage *image in images) {
	
		//2.往group里面增加一个block任务,这边的block任务就是上传一张图片
    	dispatch_group_enter(group);                                  
    sendPhoto(image, success:^(NSString *url) {
    
        [imageURLs addObject:url];
        
        //3.表示任务已经完成 需要移除
        dispatch_group_leave(group);                           
    });
	}
		//4.当group中的block任务都执行完毕以后，dispatch_group_notify 会被执行
		dispatch_group_notify(group, dispatch_get_global_queue(), ^{       
	        
	        postFeed(imageURLs, text);
	});
	
##GCD定时器
NStimer是对GCD定时器的包装。GCD定时器更加的高级，且不受runloop的影响。

	@interface ViewController ()
	
	@property (nonatomic, strong) dispatch_source_t timer;
	
	@end
	
	int count = 0;
	- (void)GCDTimer{
		
		1.获得队列
	    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
	    
	    2.创建一个定时器(dispatch_source_t本质是一个OC对象)
	    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	    
	    3.设置定时器的各种属性(几时开始任务，每个多长时间执行一次)
	    GCD的时间参数，一般是纳秒(1秒 == 10的9次方纳秒)
	    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);//何时开始第一个任务
	    dispatch_time_t interval = 2.0 * NSEC_PER_SEC; //何时开始重复任务
	    dispatch_source_set_timer(self.timer, start, interval, 0);
	    
	    4.设置回调
	    dispatch_source_set_event_handler(self.timer, ^{
	       
	        NSLog(@"-------%@",[NSThread currentThread]);
	       	count ++;
	       	
	       	if(count == 5)
	       	{
	       		//取消定时器
	       		dispatch_cancel(self.timer);
	       		self.timer = nil;
	       	}
	    });
	    
	    5.启动timer
	    dispatch_resume(self.timer);
	}

	  			  
	  