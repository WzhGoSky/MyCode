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
- 6.集合  
  - 6.1 数组
  - 6.2 字典

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

- 6.集合  
  - 6.1 数组
  - 6.2 字典