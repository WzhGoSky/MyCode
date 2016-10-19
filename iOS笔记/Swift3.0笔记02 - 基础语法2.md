#Swift3.0 基础语法2
主要分为以下几个部分:  

- 1.函数
  - 1.1 函数的定义  
  - 1.2 闭包
  - 1.3 多线程GCD的变化
  - 1.4 闭包循环引用
  - 1.5 尾随闭包
- 2.构造函数
  - 2.1 重载构造函数
  - 2.2 构造函数KVC
  - 2.3 便利构造函数  
- 3.Swift应用
  - 3.1 加法计算器
  - 3.2 加法计算器(便利构造函数)
  - 3.3 runtime加载属性列表
  - 3.4 session使用
  - 3.5 项目零散总结
 

###1.函数
####1.1函数的定义
__函数格式__ : func 函数名(形参列表) -> 返回值类型
	
	 func sum(x:Int, y: Int) -> Int {
        
        return x + y
    }

__外部参数__: 1.外部参数就是在形参前面加一个名字，不会影响函数内部细节，并且会让函数看起来更加直观。如果外部参数使用‘_’,在外部调用函数时，会忽略形参的名字.
	
	 func sum2(_ x:Int,_ y: Int) -> Int {
       
        for _ in 0..<10 {
            
            print("hello world")
        }
        
        
        return x + y
    }
__默认值__: 通过给参数设置默认值，在调用的时候就可以组合参数，如果不能指定的，就可以使用默认值 

	    func sum3(x: Int = 1, y: Int = 2) -> Int {
        
        return x + y
    }
    
    print(sum3())  //3
    print(sum3(x: 10, y: 20))  //30
    print(sum3(x: 10))     //12
    print(sum3(y: 10)) 		//11
    
__无返回值写法__:
	
	1.直接省略
	
	 func demo1() {
        
        print("11")
    }
    
    2.用()
    func demo2() -> () {
        print("11")
    }
    
    3.用Void
    func demo3() -> Void {
        
        print("11")
    }
####1.2闭包
__什么是闭包__: 类似于OC中的block,主要作用是:提前准备好代码，在需要的时候执行。还可以当做参数传递。
	
1.没有参数，没有返回值的闭包
	
	  () -> () 没有参数，没有返回值的函数
	  如果没有参数，没有返回值，可以省略，连in一起省略
	  let b1 = {
	      
	      print("hello")
	  }
	  
	  //执行闭包
	  b1()
2.带参数的闭包
	
	 (Int) -> ()
     闭包中，参数，返回值，实现代码都是写在{}中
     需要使用一个关键字 “in” 分隔定义和实现
     { (形参列表 -> 返回值类型 in 实现代码)}
     let b2 = {
         
         (x: Int) -> ()
         
         in
         
         print(x)
     }
     
     b2(100)

3.带参数，带返回值的闭包

     类型:(Int) -> Int
     let b3 = { (x: Int) -> Int in
         
         return x
     }
     
     print(b3(10))

####1.3 多线程GCD的变化
开启一个异步线程:

	 DispatchQueue.global().async { 
            
            print("耗时操作 \(Thread.current)")
        
        }
回到主线程:
	
     DispatchQueue.main.async(execute: { 
         
         print("主线程更新UI \(Thread.current)")
         

     })        

模拟异步网络请求:并把一个闭包作为参数
	
	func loadData(completion:@escaping (_ result : [String] ) -> ()) -> () {
        DispatchQueue.global().async {
            
            print("耗时操作 \(Thread.current)")
            
            //休眠
            Thread.sleep(forTimeInterval: 1.0)
            
            //获取结果
            let json = ["头条","八卦","出大事了"]
            
            //主队列回调
            DispatchQueue.main.async(execute: { 
                
                print("主线程更新UI \(Thread.current)")
                
                //回调
                completion(json)
            })
        }
    }
    
    @escaping:关键词，逃逸闭包 一些异步函数会使用逃逸闭包。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。
    作用:可以理解为延长的闭包的生命周期，当函数返回时，闭包不会被销毁，而是可以等待被调用。
####1.4 循环引用
__为什么会产生循环应用的问题__: 如果只是出现单方向的引用是不会产生循环引用的。如果self里面有一个属性对闭包进行了引用，而在闭包中也使用了self,就会造成循环引用问题。


__解除循环引用__:  
1.先使用一个属性记录下闭包:
	
	 var completionCallBack : (()->())?
	
	 func loadData(complete: @escaping () -> ()) {
        
        //使用属性记录闭包 (循环引用)
        completionCallBack = complete;
        
        DispatchQueue.global().async { 
            
            
            DispatchQueue.main.async(execute: { 
                
                complete()
                
            })
        }
    }
    
方法1:使用OC方法  

	   weak var weakSelf = self
        loadData {
            
            print(weakSelf?.view)
        }
        
细节:  
　　　1. weak只能是用var修饰，不能用let,因为weak修饰的对象 可能会在运行时被修改->指向的对象一旦被释放，就会自动设置为nil         
　　　2.解包有两种方式的解包,  
　　　   ？可选解包 -> 如果self已经被释放，不会像对象发送getter的消息,更加安全  
　　　 ! 强行解包 -> 如果self已经被释放，强行解包会导致崩溃

方法2:Swift 的推荐方法
	
	 loadData { [weak self] in
            
            print(self?.view)
        }
细节:  
　　　1.[weak self] 表示 {} 中的所有self 都是弱引用，需要解包         

方法3:Swift 的另外一个用法（一般不要用）
	
	loadData { [unowned self] in
           
            print(self.view)
        }
细节:  
　　　1. [unowned self] 表示{} 中的所有self 都是assign的，不会强引用，但是，如果对象释放，指针地址不会变化      
　　　2.如果对象被释放，继续调用，就会出现野指针  
####1.5 尾随闭包

__什么是尾随闭包__: 如果函数的最后一个参数是闭包，函数参数可以提前结束，最后一个参数直接使用{}包装闭包的代码
	
	//原本:
	 loadData(completion: { (result) -> () in
            
            
        })
     
     //尾随闭包
	 loadData { (result) in
            
            print(result)
     }

###2.构造函数
__命名空间__:  在Swift中，默认同一个项目中（同一个命名空间下），所有类都是共享的，可以直接访问，不需要 import,所有对象的属性 var,也可以直接访问到。使用cocapods 可以保证类，方法在不同的命名空间下。  

__构造函数的目的__:
1.构造函数目的:给自己的属性分配空间并且设置初始值
2.如果重载了构造函数，并且没有实现父类init方法，系统不再提供init()构造函数（默认是会有的）
 因为默认的构造函数，不能给本类的属性分配空间

__Swift构造函数的初始化过程__:
1.给自己的属性分配空间并且设置初始值
2.调用父类的“构造函数”，给父类的属性分配空间初始值，NSObject 没有属性，只有一个成员变量‘isa’

	class Person: NSObject {
    
    var name: String
 
	    override init() {
	        
	        name = "Hayer"
	        super.init()
	    }
	}
	
	() -> alloc/init 
	作用:给成员变量分配空间，初始化成员变量
	
	let p = Person()
	       
	print(p)
	    
	print("\(p.name)")
	
__Swift的初始化过程与OC相反__
  
　　Swift先初始化话自己，再初始化父类。OC先初始化父类，在初始化自己

####2.1 重载构造函数
__重载与重写__: override 与 overload
	
	override: 覆盖原有的方法
	
	 override init() {
        
        name = "Hayer"
        super.init()
    }
		
	overload: 函数名相同，参数和个数不同，重载可以给自己的属性从外部设置初始值
	
	init(name: String) {
        
        //使用参数的name 设置给属性
        self.name = name
        
        //调用父类的构造函数
        super.init()
    }
####2.2 构造函数KVC
__Swift使用KVC的注意点__:  
1.定义模型属性的时候，如果是对象，通常都是可选的  
2.如果是基本数据类型，不能设置成可选的，而且要设置初始值，否则KVC会崩溃  
3.如果使用KVC 设置数值，属性不能是private  
4.使用KVC方法之前，应该调用super.init 保证对象实例化完成  

	
	class Person: NSObject {
   
	    var name: String?
	    
	    var age: Int = 0
	    
	    //- 如果是private 属性，使用KVC 设置值得时候，同样无法设置
	    //- 如果设置成private 属性/方法，禁止外部访问
	    private var title: String?
	   
	    //重载构造函数，使用字典为本类设置初始值
	    init(dict: [String : Any])
	    {
	        //保证对象已经完全初始化完成
	        super.init()
	
	        //要求对象已经实例化完成
	        setValuesForKeys(dict)
	    }
	    
	    //重写父类的方法
	    override func setValue(_ value: Any?, forUndefinedKey key: String) {
	        
	        //没有调用super,将父类的代码实现完全覆盖，不会崩溃
	    }
	}
	
	使用:
	let p = Person(dict: ["name":"Hayder", "age": 109, "title":"BOSS"])
        
     print("\(p.name) \(p.age)")

####2.3 便利构造函数  
__便利构造函数的目的__:  
判断条件，只有满足条件，才实例化对象，可以防止造成不必要的内存开销  
简化对象的创建  
本身不负责属性的创建和初始化工作  

	class Person: NSObject {
    
    var name: String?
    var age: Int = 0
    
    convenience init?(name: String, age: Int) {
        
        if age > 100 {
            
            return nil
    	}
    
     	self.init()
    
     	self.name = name
    }
    
    // 没有func -> 不让调用
    // 没有 () -> 不让重载,不许带参数
    //在对象被销毁钱自动调用
    //类似于OC的dealloc
	    deinit {
	        
	        //1.跟踪对象的销毁
	        //2.必须释放 
	        /**
	            - 通知，不释放不会崩溃，但是崩溃
	            - KVO，不释放会崩溃
	            - NSTimer/ CADisplayLink
	         */
	    }
	}

__注意点:__  
1.便利构造函数允许返回nil  
　　- 正常的构造函数一定会创建对象  
　　- 判断给定的参数是否符合条件，如果不符合条件，直接返回nil,不会创建对象，减少内存开销  

2.遍历构造函数中使用“self.init()” 构造当前对象  
　　- 没有 convenience 关键字的构造函数是负责创建对象的，反之是用来检查条件的，本身不负责对象的创建  

3.如果要在遍历构造函数中使用当前对象的属性，一定要在self.init之后

###3.Swift应用
####3.1 加法计算器
	
	class ViewController: UIViewController {

    var result: UILabel?
    var numText1: UITextField?
    var numText2: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    /// 计算结果
    func calc() {
        
        //将文本框内容转换为数值
        //Int? 如果文本框内容不是数字 Int之后是nil
        //先测试：let num1 = Int(numText1?.text ?? "")如果不是数字就会输出为空
        guard let num1 = Int(numText1?.text ?? ""),let num2 = Int(numText2?.text ?? "")
            else {
            
                print("必须输入数字才能进行计算")
                
                return
        }
        
        result?.text = "\(num1 + num2)"
    }
    
    func setUpUI() -> () {
        
        //1.两个 textField
        let tf1 = UITextField(frame:CGRect(x: 20, y: 20, width: 100, height: 30))
        tf1.borderStyle = .roundedRect
        tf1.text = "0"
        
        view.addSubview(tf1)
        
        let tf2 = UITextField(frame:CGRect(x: 140, y: 20, width: 100, height: 30))
        tf2.borderStyle = .roundedRect
        tf2.text = "0"
        
        view.addSubview(tf2)
        
        //记录属性
        numText1 = tf1
        numText2 = tf2
        
        //2. 3个 label
        let label1 = UILabel(frame: CGRect(x: 120, y: 20, width: 20, height: 30))
        label1.text = "+"
        label1.textAlignment = .center
        view.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 240, y: 20, width: 20, height: 30))
        label2.text = "="
        label2.textAlignment = .center
        view.addSubview(label2)
        
        let label3 = UILabel(frame: CGRect(x: 260, y: 20, width: 80, height: 30))
        label3.textAlignment = .center
        label3.text = "0"
        view.addSubview(label3)
        
        self.result = label3
        
        //4.1个button
        let button = UIButton()
        
        button.setTitle("计算", for: UIControlState(rawValue : 0))
        button.setTitleColor(UIColor.black, for: .normal)
        
        button.sizeToFit()
        button.center = view.center
        
        button.addTarget(self, action: #selector(calc) , for: .touchUpInside)
        view.addSubview(button)
    }

	}

####3.2 加法计算器(便利构造函数)
使用分类

	extension UITextField{
	    
		convenience init(frame: CGRect, placeholder: String, fontSize: CGFloat = 14)
		    {
		        //实例化对象
		        self.init(frame: frame)
		        
		        //访问属性
		        self.borderStyle = .roundedRect
		        self.placeholder = placeholder
		        self.font = UIFont.systemFont(ofSize: fontSize)
		    }
	}
	
	extension UIButton{
    
	    convenience init(title: String,target:Any?, action: Selector) {
	        
	        self.init()
	        
	        self.setTitle(title, for: UIControlState(rawValue : 0))
	        self.setTitleColor(UIColor.black, for: .normal)
	        self.sizeToFit()
	        self.addTarget(target, action: action , for: .touchUpInside)
	             
	    }
	}
	
	class ViewController: UIViewController {

    var result: UILabel?
    var numText1: UITextField?
    var numText2: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    /// 计算结果
    func calc() {
        
        guard let num1 = Int(numText1?.text ?? ""),let num2 = Int(numText2?.text ?? "")
            else {
            
                print("必须输入数字才能进行计算")
                
                return
        }
        
        result?.text = "\(num1 + num2)"
    }
    
    func setUpUI() -> () {
        
        //1.两个 textField
        let tf1 = UITextField(frame: CGRect(x: 20, y: 20, width: 100, height: 30), placeholder: "0", fontSize: 14)
        
        view.addSubview(tf1)
        
        let tf2 = UITextField(frame:CGRect(x: 140, y: 20, width: 100, height: 30), placeholder: "0", fontSize: 14)
        view.addSubview(tf2)
        
        //记录属性
        numText1 = tf1
        numText2 = tf2
        
        //2. 3个 label
        let label1 = UILabel(frame: CGRect(x: 120, y: 20, width: 20, height: 30))
        label1.text = "+"
        label1.textAlignment = .center
        view.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 240, y: 20, width: 20, height: 30))
        label2.text = "="
        label2.textAlignment = .center
        view.addSubview(label2)
        
        let label3 = UILabel(frame: CGRect(x: 260, y: 20, width: 80, height: 30))
        label3.textAlignment = .center
        label3.text = "0"
        view.addSubview(label3)
        
        self.result = label3
        
        //4.1个button
        let button = UIButton(title: "计算",target: self,action: #selector(calc))
        button.center = view.center
        
        view.addSubview(button)
       
    }

}
####3.3 runtime加载属性列表

	class Person: NSObject {
    
    var name: String?
    var age: Int = 0
   
    class func propertylist() -> ([String]){
        
        var count: UInt32 = 0
        //1.获取“类”的属性列表
        //outCount: UnsafeMutablePointer<UInt32>! 可变的
        let list = class_copyPropertyList(self, &count)
        
        print("属性的数量 \(count)")
        
        var result: [String] = []

        //遍历数组
        for i in 0..<Int(count){
            
            //3.根据下标获取属性
            //使用 guard 语法，依次判断每一项是否有值，如果一项为nil，就不再执行后续代码
            guard let pty = list?[i],
                 let cName = property_getName(pty),
                 let name = String(utf8String: cName)
            else {
                
                //继续访问下一个
                continue
            }
            
            //name 一定有值
            result.append(name)
        }

        //3.释放C语言对象
        free(list)
    
        return result
    	}
	}
	
	使用：print(Person.propertylist())
	
注意点:  
1.基本数据类型，在OC中没有可选，如果定义成可选，运行时同样获取不到，使用KVC就会崩溃  
2.private 的属性，使用运行时，同样获取不到属性(可以获取到ivar),同样会使KVC崩溃
	
####3.4 session使用
	
	 if let url = URL(string: "http://www.baidu.com")
       {
        //发起网络请求
        //和OC 的区别，闭包的所有参数需要自己写，OC是直接写入
        // - 如果不关心，可以直接‘_’忽略
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else{
                
                print("网络请求失败")
                return
            }
            
            let html = String(data: data, encoding: .utf8)
            
            print(html)
            
            }.resume()

        }else
       {
            print("url 为nil")
        }

    }

####3.5项目零散总结

在项目中做类型转换一般使用: as

    1.Swift中String之外，绝大多数使用 as 需要？ /!
    2.as? / as! 直接根据前面的返回值来决定
    3.注意 if let 、guard let 判空语句，一律使用as?
	
	destination类型: var destination: UIViewController { get }
	let vc = segue.destination as! DetailController
	
	sender类型:let sender: Any?
	if let indexpath = sender as? IndexPath
执行闭包回调
	
	1.！强行解包 -> 闭包一定不要用！
    2.？可选解包 ->如果闭包为nil,就什么也不做
    completionCallBack?()
        