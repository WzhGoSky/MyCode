#NSURLSession
>主要从3个方面对NSURLSession进行学习  
1.NSURLSession优势在哪。(为什么苹果要使用NSURLSession来替代NSURLConnection)  
2.NSURLSession介绍。  
3.NSURLSession具体使用。
4.关于Session的控制

##1.NSURLSession优势在哪。(为什么要使用NSURLSession来替代NSURLConnection) 
####1.1 下载速度
　　在2015年RFC 7540正式发表了下一代HTTP协议，是1999年以来HTTP/1.1发布后的首个更新。相对HTTP1.1,HTTP/2更加快速。  
　　对于相同图片、相同服务器下载，在HTTP/1.1和HTTP/2协议下的对比图:  
　　![images](https://github.com/WzhGoSky/NoteImages/blob/master/iOS%E7%AC%94%E8%AE%B05-NSURLSession/1.jpg)  
　　
　 HTTP/2比HTTP/1.1在速度上快很多，iOS9开始，NSURLSession开始全面的支持HTTP/2。
####1.2 能够暂停和恢复网络操作
　　使用NSURLSession API能够暂停，停止，恢复所有的网络任务，再也完全不需要子类化NSOperation. 并且默认任务运行在其他非主线程中。
　　
####1.3 提高认证处理
　　认证是在一个指定的连接基础上完成的。在使用NSURLConnection时，如果发出一个访问，会返回一个任意的request。此时，你就不能确切的知道哪个request收到了访问。而在NSURLSession中，就能用代理处理认证。
####1.4 可配置的容器
　　对于NSURLSession里面的requests来说，每个NSURLSession都是可配置的容器。举个例来说，假如你需要设置HTTP header选项，你只用做一次，session里面的每个request就会有同样的配置。
  
##2.NSURLSession介绍。
####2.1NSURLSession类继承关系
![images](https://github.com/WzhGoSky/NoteImages/blob/master/iOS%E7%AC%94%E8%AE%B05-NSURLSession/2.png)

>在NSURLSession中，网络请求基本由3个任务完成:  
　　1.NSURLSessionData：请求数据任务  
　　2.NSURLSessionUploadTask：请求上传任务  
　　3.NSURLSessionDownloadTask：请求下载任务

####2.2NSURL代理协议类继承关系
![images](https://github.com/WzhGoSky/NoteImages/blob/master/iOS%E7%AC%94%E8%AE%B05-NSURLSession/3.png)

####2.3NSURLSession使用步骤
1.创建一个URL

	NSURL *url = [NSURL URLWithString:@"协议://主机地址/路径?参数&参数"];

2.创建NSURLRequest请求 
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
	
	url:资源路径

	cachePolicy:缓存策略。（无论使用哪种缓存策略，都会在本地缓存数据）	NSURLRequestUseProtocolCachePolicy = 0 //默认的缓存策略，使用协议的缓存策略	NSURLRequestReloadIgnoringLocalCacheData = 1 //每次都从网络加载	NSURLRequestReturnCacheDataElseLoad = 2 //返回缓存否则加载，很少使用	NSURLRequestReturnCacheDataDontLoad = 3 //只返回缓存，没有也不加载，很少使用
	
	timeoutInterval:超时时长，默认60s.
	
注意：request还可以设置一些其他的信息，比如请求头，请求体等。此时的request要为NSMutableRequest类型。
	
	// 告诉服务器数据为json类型
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; 
	// 设置请求体(json类型)
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"userid":@"123456"} options:NSJSONWritingPrettyPrinted error:nil];
	request.HTTPBody = jsonData;

3.创建会话:NSURLSession  
4.通过会话创建务:NSURLSessionDataTask,NSURLSessionUploadTask,NSURLSessionDownloadTask  
5.调用resume方法启动任务。（每一个任务都是默认挂起的，需要调用resume方法）

##3.NSURLSession具体使用。
####3.1 NSURLSessionDataTask进行GET请求
	 //1.创建URL
    NSURL *url = [NSURL URLWithString:@"http://test.igenshang.com:8001/openapi/api/event/addEventRecord?"];
    
    //2.NSMutableURLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
    request.HTTPMethod = @"GET";
    
    //3.创建NSURLSession对象(使用一个全局会话对象)
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.通过会话创建任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dict);
        }
        
    }];
    
    //5.启动任务
    [task resume];
####3.2 NSURLSessionUploadTask进行文件上传
>与NSURLConnection的文件上传相比的好处:简单，不需要我们自己构建上传请求，主要是不用拼接上传的表单。

#####常用的创建上传任务的方法
	1.fromFile: 传入参数是上传文件所在的URL路径，这个方法长配合'PUT'请求使用
	- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler ;
	
	2.fromData: 传入的参数是上传文件的二进制数据 (常用)
	- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
	
上传文件也和dataTask一样分成5步

	- (void) NSURLSessionBinaryUploadTaskTest {
    // 1.创建url，采用Apache本地服务器进行测试
    NSString *urlStr = @"http://localhost/upload.php";
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2.创建请求，这里要设置POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";// 文件上传使用post
    // 3.获取全局会话Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.创建上传任务，Request的Body Data将被忽略，而由fromData提供
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/userName/Desktop/IMG_0359.jpg"];
    NSURLSessionUploadTask *upload =
           [session uploadTaskWithRequest:request 
                                 fromData:data     
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"upload success：%@",result);
        } else {
            NSLog(@"upload error:%@",error);
        }
    }]
    // 5.启动任务
    [upload resume];
}

####3.３ NSURLSessionDownloadTask进行文件下载
#####常用的创建下载任务的方法
	1.利用request 进行下载任务
	- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;
	2.对于不需要设置请求属性的下载任务来说 传入URL即可进行下载请求
	- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;
	
	进行下载
	
	-(void)downloadTask{
    //1.创建url
    NSString *fileName = @"1.jpg";
    NSString *urlStr = [NSString stringWithFormat: @"http://192.168.1.208/FileDownload.aspx?file=%@",fileName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //3.创建会话（这里使用了一个全局会话）
    NSURLSession *session = [NSURLSession sharedSession];
    //4.创建文件下载任务
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request 
          completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            //注意location是下载后的临时保存路径,需要将它移动到需要保存的位置
            NSError *saveError;
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath = [cachePath stringByAppendingPathComponent:fileName];
            NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
            
            //将location路径下的文件移动到需要保存的路径下
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            if (!saveError) {
                NSLog(@"save sucess.");
            }
        }
    }];
    	//5.启动任务
    	[downloadTask resume];
	}
##4.会话Session控制。

