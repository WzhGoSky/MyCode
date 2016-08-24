#多线程------GCD概念
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
	GCD默认提供全局并发队列，供整个应用使用，不需要手动创建
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

#####总结
	1.同步函数不具备开启线程的能力，无论什么队列都不会开始线程。
	2.异步函数具备开启线程的能力，开启线程的条数由队列决定。（串行队列为1条，并行队列为多条）
	
	异步函数具备开线程的能力，但是不一定会开启线程。
	