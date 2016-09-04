#NSURLSession
>主要从3个方面对NSURLSession进行学习  
1.NSURLSession优势在哪。(为什么苹果要使用NSURLSession来替代NSURLConnection)  
2.NSURLSession介绍。  
3.NSURLSession具体使用。

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
####3.2 NSURLSession
	
