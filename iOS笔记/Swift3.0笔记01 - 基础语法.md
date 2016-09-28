#Swift3.0 基础语法 
主要分为以下几个部分 ：  

- 1.变量和常量  
- 2.可选项Optional  
  - 2.1 '?' 和 ‘!’使用
  - 2.2 可选项的判断
- 3.逻辑分支
  - 3.1 if
  - 3.2 switch   
- 4.循环   
- 5.字符串  
  - 5.1 字符串遍历
  - 5.2 字符串长度
  - 5.3 拼接
  - 5.4 格式化
  - 5.5 字符串的子串
- 6.集合  
  - 6.1 数组
    - 6.1.1 数组的定义
    - 6.1.2 数组的遍历
    - 6.1.3 数组的增/删/改
    - 6.1.4 数组的容量
    - 6.1.5 数组的合并
  - 6.2 字典
    - 6.2.1 字典的定义
    - 6.2.2 字典的增删改
    - 6.2.3 字典的遍历
    - 6.2.4 字典的合并
    

###1.变量和常量
注意点:
>1.定义变量 var，定义之后，可以修改.  常量 let, 定义之后，不能修改.  
所谓修改，就是修改指向
	
	let v = UIView()
        
    //仅仅修改的是V的属性，并没有修改v的指针地址
    v.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
	view.addSubview(v)

> 2.在Swift中对类型要求异常严格,__（重要）任何不同类型的数据之间，不允许直接运算.__不会做默认的隐式的转换，所有的类型确定，都要由程序员负责。  

	 let x = 10
     let y = 10.5
      
     1. 将y装换成整数
     print(x + Int(y))
      
     2.将 x 转换成Double
     print(Double(x) + y)

 >3.在Swift中，不存在基本数据类型，都是__结构体。__
 	
 	  OC中的写法（int）y - > 类型强转
      Swift 中 Int() 结构体的构造函数
      
> 4.变量/常量的类型会根据右侧的代码执行结果，推倒对应的类型。    

 
如果需要制定变量/常量的类型，也可以直接使用let x : 类型 = 值  
   提示:在Swift 开发中，极少使用直接制定类型，通常都是自动推导  
   
	let x : Double = 10
    let y = 10.5

###2.可选项Optional
####2.1 '?' 和 ‘!’
>'?' 用来定义变量是一个可选的类型，可能没有值，也可能是没值.  
        
         常量y 使用之前必须初始化
        let y: Int? = 20
        
        输出结果Optional(10), 提示这是一个可选值
        print(x)
        print(y)	
> "!" 强行解包 - 从可选值中强行获取对应的非空值，如果是nil，就会奔溃
	
	    let x = 10
     
        let y: Int? = 20
        
        //输出结果Optional(10), 提示这是一个可选值
        print(x)
        print(y)
        
        //不同类型之间的值不能直接运算! 如果没有值是 nil 不是任何数据类型，不能参与计算
        print(x + y)

        print(x + y!)


 　什么时候用‘?’  , 什么时候用‘!’

　　1.定义可选项的时候用‘?’  
　　2.解包使用'!',准备计算


  __var 的可选值默认为nil, let 的可选值没有默认值__

　 
####2.2 可选项的判断

如果有一个函数,需要打印x + y 的值如下:
	 
	 func Demo(x: Int?, y: Int?) {
        
     }
__方法1__:强行解包,但有风险
		
		
        print(x! + y!)

__方法2__:使用if判断,但是: 如果直接使用if，一不小心，会让代码很丑陋        
       
        if x != nil && y != nil  {
            
            print(x! + y!)
        }else
        {
            print("x 或者 y 为nil")
        }
__方法3__:使用‘??‘,一个简单的三目运算符 
	
	   /**
         - 如果有值，使用值
         - 如果没有值， 使用？？ 后面的值替代
        */
        print((x ?? 0) + (y ?? 0))

__方法4__: if var / let 连用语法，目的就是判断值。并不是单纯的if

	if let 判断值是否为nil,{}内一定有值，可以直接使用，不需要解包
	if var  连用，{}可以对值进行修改!
	
	 let oName: String? = "老王"
         let oage: Int? = 10
        
        if let name = oName,
           let age = oage{
            
            //进入分支之后，name 和 age 一定有值，不需要解包
            //name 和 age的作用域尽在()中
            print(name + String(age))
            
        }else{
            
            print("name 或 age 为 nil")
        }
__方法5__: guard 

	 let oName: String? = "老王"
        let oage: Int? = 10
        
        guard let name = oName,
              let age = oage else {
            
            print("姓名或者年龄为nil")
            return
        }
        
        后续代码....

执行完guard代码后，name 和 age 一定有值,通常判断是否有值之后，会做具体的逻辑实现，通常代码比较多。  
__好处:__
如果用if let 凭空多了一层分支，guard 是降低分支层次的办法

#####guard let & if let 的取名技巧 --->使用同名的变量
__好处1.使用同名的变量接受值，在后续使用的都是非空，不需要解包。好处2.可以避免起名字的烦恼__

###3.逻辑分支
####3.1 if判断
__注意点:__  
1.条件不需要有()  
2.语句必须有{}

	   if x > 5{
            
          print("大");
          
        }else
        {
            print("小")
        }
#####三目运算符,语法和OC一样(常用)
	
	   let x = 10
    
        x > 5 ? print("大") : print("小")
        
        //'()' 表示空执行
        x > 5 ? print("大") : ()
####3.2 Switch
__Switch在Swift与OC的区别__  
__OC__ 中:

    1.OC中 Switch() 中的值必须是整数
    2.每个语句都需要一个 break
    3.如果要定义局部变量，需要{}
    4.OC中{}可以限定变量的作用域。
__Swift__中:
	
	 1.Swift 可以针对任意类型的值进行分支，不再局限整数
     2.Swift 一般不需要break
     3.Swift 如果需要多值,使用‘,’
     4.所有的分支至少需要一条指令，如果什么都不干，才使用break

__使用__中:

	  switch num {
        case "10","9":
            
            print("优")
            
        default:
            print("一般")
        }

###4.循环   
__开区间循环__
	
	   变量 i 在 [0,5)循环
        for i in 0..<5 {
            
            print(i)
        }
__闭区间循环__
	
	变量 i 在 [0,5]循环
	for i in 0...5 {
            
            print(i)
        }

__区间说明__

	   可计算的闭区间
       //CountableClosedRange<Int>
       let r1 = 0...5
       
       可计算的区间
       // CountableRange<Int>
       let r2 = 0..<5  
__逆序循环__

	  for i in (0..<10).reversed() {
            
            print(i)
        }
          
###5.字符串  
__Swift中String的特点:__
	
	1.String 是一个结构体，性能更高
	2.String 目前具有绝大多数NSString功能
	3.String 支持直接遍历
	4.NSString 是一个OC对象，性能略差
	
####5.1 字符串遍历
	
	 let str = "hayder"
        
        for c in str.characters {
            
            print(c)
        }
####5.2 字符串长度 

__方法1__:返回指定编码的对应的字节数量
	
	 let str = "hello world"
       
     //UTF8的编码{0-4个}，每个汉字是3个字节
     print(str.lengthOfBytes(using: .utf8))
     
__方法2__:字符串长度 -> 返回字符的个数

	let str = "hello world"
	
    print(str.characters.count);
    
__方法3__:使用NSString 中转  

	let str = "hello world"
  	    
    let ocStr = str as NSString
    
    print(ocStr.length)
####5.3 字符串拼接
字符串拼接需要注意: 可选项 Optional
	
	let name = "Hayder"
    let age = 18
    let title: String? = "BOSS"
    let point = CGPoint(x: 100, y: 100)

    //\(变量/常量)
    //NSStringFromCGPoint(point)
    let str = "\(name) is \(age) \(title ?? "") \(point)"
    
    print(str)
####5.4 格式化
	
	 let h = 8
     let m = 9
     let s = 6
     
     //使用格式字符串格式化
     let dateStr = String(format: "%02d:%02d:%02d", h,m,s)
     print(dateStr)
####5.5 字符串的子串 -> 截取范围字符串
推荐使用:将NSString 作为中转，Swift中的取子串的一直在优化
	
	 let str = "我们一起飞"
     let ocstr = str as NSString
     
     let s1 = ocstr.substring(with: NSMakeRange(2, 3))
     
     print(s1)
###6.集合  
####6.1 数组
	
	 1. OC使用[] 定义数组。Swift一样， 但是没有“@”
     2. 自动推导的结果[String] -> 表示数组中存放的都是String
     3. Swift中的基本数据类型不需要包装
#####6.1.1 数组的定义

	 let arr = ["张三","小芳","小羊"]
        
        print(arr)
        
        //CG结构体[CGPoint]
        let p = CGPoint(x: 10, y: 300)
        let arr3 = [p]
        print(arr3)
        
        //混合数组:开发中几乎不用，因为数组是靠下标索引
        //如果数组中的类型不一致，自动推导的结果[NSObject]
        //在Swift中还有一种类型[AnyObject] -> 任意对象
        //在Swift中一个类可以没有任何‘父类’
        //***在混合的数据中，CG机构体需要包装
        let arr4 = ["张三", 1] as [Any]
        print(arr4)

#####6.1.2 数组的遍历

      let arr = ["张三","小芳","小羊"];

__1.按照下标遍历__  

	    for i in 0..<arr.count {
	        
	        print(arr[i])
	    }
__2.for in 遍历元素__         
      
        
	    for s in arr {
	        
	        print(s)
	    }
        
__3.enum block遍历 ，同时遍历下标和内容__
        
        
	    元组 (offset: Int, element: String)
	    for e in arr.enumerated() {
	        
	        print(e)
	    }
	        
__4.遍历下标和内容2__

		 1. n 就是索引下标
	     2. s 就是[String] 数组 n 对应的 String 元素
	     3. 其中n/s 的名字可以随便写
	      
	    for (n,s) in arr.enumerated() {
	       
	       print("\(n) ---- \(s)")
	    }
        
__5.反序遍历__
    
  
		for s in arr.reversed() {
	       
	       print(s);
		}
        
__6.反序索引 & 内容(必须是enum在前， reve在后)__

	    for (n,s) in arr.enumerated().reversed() {
	        
	         print("\(n) ---- \(s)")
	    }

#####6.1.3 数组的增/删/改
__OC中数组分可变 NSMutableArray(var) / 不可变 NSArray(let)__
        
        var arr = ["张三","小芳","小羊"];
        
        //追加元素(增)
        arr.append("老王")
        print(arr)
        
        //修改，通过下标定位(改)
        arr[0] = "小王"
        print(arr)
        
        //数组越界,不能修改
        arr[5] = "xxx"
        print(arr)
        
        //删除(删)
        arr.remove(at: 3)
        
        //删除全部，并且保留空间
        arr.removeAll(keepingCapacity: true)

#####6.1.4 数组的容量

__设定容量可以略微的提高性能。__
        
        //定义一个数组，指定类型是 存放Int的数组，但是没有初始化
        var array: [Int]
        
        //给数组初始化
        array = [Int]()
        
        //以上两句代码可以合并成一句
        var arr = [Int]()
        
        for i in 0..<8 {
            
            arr.append(i)
            
            //插入元素时，如果容量不够，会*2（初始0） 0 ,2,4,8,16
        }

#####6.1.5 数组的合并 
__注意:要合并数组的两个类型必须一致__
	
	   //var arr: [String]
       var arr = ["张三","小芳","小羊"] as [Any];
       
       //let arr2: [Any]
       let arr2 = ["Hayder",10] as [Any]
       
       //将array2的内容合并到array中
       //
       arr += arr2
       
       print(arr)
####6.2 字典
#####6.2.1 字典的定义
		1.OC 定义字典使用{}
		2.Swift中使用[]
        
		[KEY: VALUE] -> [String : Any]
		let dic = ["name" : "张","age" : 10] as [String : Any]
		
		print(dic)
		
		//定义字典的数组
		let array:[[String : Any]] = [
		
			["name" : "张","age" : 10],
			["name" : "张","age" : 10]
		]
#####6.2.2 字典的增删改
	
		//可变 var / 不可变 let
		var dic = ["name" : "张","age" : 10] as [String : Any]
		
		//新增 - 如果 KEY 不存在，就是新增
		dic["title"] = "大哥"
		print(dic)
		
		//修改 - 字典中是通过KEY取值，KEY在字典中必须是唯一的
		//如果KEY值存在就是修改
		dic["name"] = "大西瓜"
		print(dic)
		
		//删除 - 直接给定KEY
		// *** 科普，字典是通过 KEY 来定位值的， KEY 必须是可以 'hash 哈希' MD5一种
		//hash 就是将字符串变成唯一的‘整数’，便于查找， 提高字典遍历的素组
		dic.removeValue(forKey: "age")
		print(dic)

#####6.2.3 字典的遍历

		let dic = ["name" : "hayder","age": 10,"title":"老王"] as [String : Any]
		
		方式1：
		//元组 (key: Sting , value: Any)
		for e in dic {
		
			print("\(e.key),\(e.value)")
		}
		
		print("-----")
		
		/**
		前面的是 KEY
		后面的 是 VALUE
		
		具体的名字可以随便
		*/
		方式2:
		for (key, value) in dic
		{
			print("\(key),\(value)")
		}
#####6.2.4 字典的合并 
	
		var dic1 = ["name" : "hayder","age": 10,"title":"老王"] as [String : Any]
		let dic2 = ["name": "大瓜","height": 1.9] as [String : Any]
		
		//将dict2 合并到dict1
		//字典不能直接相加
		
		//思路，遍历 dict 2 依次设置
		//如果 key 存在，会修改
		//如果 key 不存在，不会修改
		for e in dic2
		{
			dic1[e.key] = dic2[e.key]
		}
        