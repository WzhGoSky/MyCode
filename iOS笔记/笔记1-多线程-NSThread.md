#多线程 --- NSThread
##创建和启动线程简单说明
    一个NSThread对象就代表一个线程
###1.创建，启动线程
####1.1创建线程（3中方法）
#####方法1：
    1.创建一个线程
	NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
	
	2.启动一个线程
	[thread start];
	
    执行完上面两个步骤以后，就会在线程NSThread中执行self的run方法
    
#####方法2：
	创建线程后自动启动线程
	[NSThreaddetachNewThreadSelector:selftoTarget:@selector(run) withObject:nil];
#####方法3:
	隐式创建并启动线程  obj为run方法中传入的参数 没有传nil
	[self performSelectorInBackground:@selector(run) withObject:nil];

#####线程参数设置
	1.设置线程的调度优先级 调度优先级的取值范围是0.0 ~ 1.0，默认0.5，值越大，优先级越高
    + (BOOL)setThreadPriority:(double)p;
    
      获取优先级
    + (double)threadPriority;
    
    2.设置线程的名字
    - (void)setName:(NSString *)n;
    
    - (NSString *)name;
    
    3.获取当前的线程
    NSThread *current = [NSThread currentThread];
#####3种方法的区别
	方法1  优点:可以对线程进行一些详细的设置，如：线程名，优先级
		  缺点:需要执行start方法才能启动线程
	方法2，3 优点:快速创建线程执行方法 
	 		缺点:无法对线程属性进行设置
###2.主线程的相关用法
	
	+ (NSThread)mainThread;   获得主线程
	+ (BOOL)isMainThread;    是否为主线程
	- (BOOL)isMainThread;    是否为主线程
	
	在主线程中执行某些方法
	方式1
	[self performSelectorOnMainThread:@selector(settingImage:) withObject:image waitUntilDone:NO];
	方式2
	[self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
	方式3
	[self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
	
###3.NSThread应用例子（线程之间的通讯）
####应用场景：
	1.一个线程传数据给另外一个线程
	2.在一个线程中执行完特定的任务后，转到另外一个线程继续执行任务
####线程间通讯常用方法
	在主线程中执行某个方法
	- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;
	在子线程中执行某个方法
	- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait;

####应用场景
	点击屏幕开始下载图片
	-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
	{
		 [self performSelectorInBackground:@selector(download) withObject:nil];
	}
	
	-(void)download
	{
		1.下载图片
		NSURL *urlstr=[NSURL URLWithString:@"bigSea"];
		
		2.把图片转换为二进制的数据
		NSData *data=[NSData dataWithContentsOfURL:urlstr];//这一行操作会比较耗时
	
		3.把数据转换成图片
	 	UIImage *image=[UIImage imageWithData:data];
	 	
	 	4.回到主线程设置图片
	 	[self performSelectorOnMainThread:@selector(settingImage:) withObject:image waitUntilDone:NO];
	}
	
	
	-(void)settingImage:(UIImage *)image
	{
		self.iconView.image=image;
	}
	
	