#多线程-NSOperationQueue 

	
##NSOperation
	NSOperation是个抽象类,并不具备封装操作的能力,必须使⽤它的子类.
	
	使用NSOperation⼦类的方式有3种：

	（1）NSInvocationOperation

	（2）NSBlockOperation

	（3）自定义子类继承NSOperation,实现内部相应的⽅法
	
###说明:
####1.一个NSoperation对象可以通过调用start方法来执行任务，默认是同步执行的。
	//1.创建一个NSInvocationOperation对象
	NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(test) object:nil];
	
	//执行操作
	[operation start];
	
	---------------------------------------------分隔线-------------------------------------------
	
	//创建NSBlockOperation操作对象 
	1.NSBlockOperation对象有一个block(任务) 只会同步执行
	NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
	
		NSLog(@"NSBlockOperation------%@",[NSThread currentThread]); //打印结果 num = 1   
		
	}];
     
    //开启执行操作
    [operation start];
    
    ---------------------------------------------分隔线-------------------------------------------
    2.NSBlockOperation对象有>1个block(任务) 就会异步执行
    
    NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
    
        NSLog(@"NSBlockOperation------%@",[NSThread currentThread]); //打印结果 num = 1
        
    }];
	
	/添加操作2
	[operation addExecutionBlock:^{
	
		 NSLog(@"NSBlockOperation1------%@",[NSThread currentThread]); //打印结果 num = 3
    }];
    
    /添加操作3
	[operation addExecutionBlock:^{
	
		 NSLog(@"NSBlockOperation1------%@",[NSThread currentThread]); //打印结果 num = 2
    }];
    
    //开启执行操作
    [operation start];
	
####2.将NSOperation添加到一个NSOperationQueue(操作队列)中去执行，而且是异步执行的。
	NSOperation 与 NSOperationQueue实现多线程的具体步骤
	
	1.将一个需要执行的任务封装到一个NSOperation对象中。
	
	 
	
	2.然后将NSOperation对象添加到NSOperationQueue中。
	
	3.系统将Queue中的Operation取出，并在一条新的线程中执行
