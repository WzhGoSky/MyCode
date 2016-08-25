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
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];  
	
	1.将一个需要执行的任务封装到一个NSOperation对象中。
	
	 NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
    
        NSLog(@"NSBlockOperation------%@",[NSThread currentThread]); //打印结果 num = 1
        
    }];

	2.然后将NSOperation对象添加到NSOperationQueue中。
	//3种方式
	//1.添加一个operation
	[queue addOperation:operation]; 
	
	//2.添加一组operation
	[queue addOperations:operations waitUntilFinished:NO];  
	
	//3.添加一个block形式的operation
	[queue addOperationWithBlock:^() {  
	
    	NSLog(@"执行一个新的操作，线程：%@", [NSThread currentThread]);  
	}];  
	
	3.系统将Queue中的Operation取出，并在一条新的线程中执行
	
	注意点：NSOperation添加到queue之后,绝对不要再修改NSOperation对象的状态。因为NSOperation对象可能会在任何时候运行,因此改变NSOperation对	象的依赖或数据会产生不利的影响。你只能查看NSOperation对象的状态, 比如是否正在运行、等待运行、已经完成等
	
####添加NSOperation的依赖对象
	1.当某个NSOperation对象依赖于其它NSOperation对象的完成时，就可以通过addDependency方法添加一个或者多个依赖的对象，只有所有依赖的对象都已经完成操作，当前NSOperation对象才会开始执行操作。另外，通过removeDependency方法来删除依赖对象。
	
	//操作2 依赖于 操作1
	[operation2 addDependency:operation1];  
	
	依赖关系不局限于相同queue中的NSOperation对象，NSOperation对象会管理自己的依赖。因此完全可以在不同的queue之间的NSOperation对象之间创建依赖。
	
	唯一的限制是不能创建环形依赖，比如A依赖B，B依赖A。这个就是错误的
	
	依赖关系会影响到NSOperation在queue中的执行顺序。

####NSOperation的执行顺序
	
	