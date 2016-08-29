#动画 Animation

##1.CALayer简介
###　　1.1 CALayer与UIView之间的关系
>　　　　UIView 能显示内容，全靠它内部有一个CALayer。
	
####　　UIView显示过程:  
　　在创建一个UIView的时候，内部会自动创建一个图层(即CALayer对象)。通过UIView的layer属性可以访问到这个对象。当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示。
	  
####　　小结:　　
　　 UIView本身不具备显示的功能，是它内部的层才有显示功能。 因此，通过调节CALayer对象，可以很方便的调整UIView的一些外观属性。
	  
###　　1.2 CALayer基本属性　

|属性	|说明	|是否支持隐式动画|
|:-------:|:--------|:---------:|
|anchorPoint	|和中心点position重合的一个点，称为“锚点”，锚点的描述是相对于x、y位置比例而言的默认在图像中心点(0.5,0.5)的位置	|是|
|backgroundColor	|图层背景颜色	|是|
|borderColor	|边框颜色	|是|
|borderWidth	|边框宽度|	是|
|bounds	|图层大小	|是|
|contents	|图层显示内容，例如可以将图片作为图层内容显示	|是|
|contentsRect	|图层显示内容的大小和位置|	是|
|cornerRadius	|圆角半径	|是|
|doubleSided	|图层背面是否显示，默认为YES|	否|
|frame	|图层大小和位置，不支持隐式动画，所以CALayer中很少使用frame，通常使用bounds和position代替	|否|
|hidden	|是否隐藏	|是|
|mask	|图层蒙版|	是|
|maskToBounds	|子图层是否剪切图层边界，默认为NO	|是|
|opacity	|不透明度 ，类似于UIView的alpha,但与其相反	|是|
|position	|图层中心点位置，类似于UIView的center|	是|
|shadowColor	|阴影颜色	|是|
|shadowOffset	|阴影偏移量|	是|
|shadowOpacity	|阴影透明度，注意默认为0，如果设置阴影必须设置此属性	|是|
|shadowPath	|阴影的形状|	是|
|shadowRadius	|阴影模糊半径|	是|
|sublayers	|子图层|	是|
|sublayerTransform	|子图层形变|	是|
|transform	|图层形变| 是|

###　　1.3 Position与anchorPoint作用
　    　　　在CALayer众多属性中，Postion与anchorPoint 这两个属性比较让人困惑。

	　　　　postion属性主要是用来确定当前图层在父图层(super CALayer)上的位置。
	　　　　archorPoint属性是用来确定当前图层上面的哪个点在position上。以自己的左上角为原点(0, 0)。它的x、y取值范围都是0~1，默认值为中心点（0.5, 0.5）
###　　1.4 隐式动画
####　　1.4.1 根层与非根层
#####　　根层: 每一个UIView内部都默认关联着一个CALayer，我们可用称这个Layer为Root Layer（根层）
#####　　非根层: 手动创建的CALayer对象。所有的非Root Layer，都存在着隐式动画。当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果，而这些属性称为Animatable Properties(可动画属性)。
####　　1.4.2 关闭隐式动画
		  [CATransaction begin];
			// 关闭隐式动画
		  [CATransaction setDisableActions:YES];

		  self.myview.layer.position = CGPointMake(10, 10);

          [CATransaction commit]; 
　　　　　　　　

##2.Core Animation
###在iOS中Core Animation层的动画是依赖CAAnimation类实现的。既然有Core Animation层动画那就应该有其他层动画。(越底层的层动画自由度越高，比如手游的动画，用coreAnimation实现许多特效是没法完成的)
![images](https://github.com/WzhGoSky/MyCode/blob/master/imgaes/%E5%8A%A8%E7%94%BB/1.png)

### CoreAnimation 结构图
![images](https://github.com/WzhGoSky/MyCode/blob/master/imgaes/%E5%8A%A8%E7%94%BB/2.png)

####说明:
####灰色虚线是继承关系，红色表示遵守协议。 核心动画中所有类都遵守CAMediaTiming协议。

####动画开发步骤
	1>初始化一个动画对象(CAAnimation)并设置一些动画相关的属性
	
	　　CALayer中很多属性都可以通过CAAnimation实现动画效果, 包括opacity, position, transform, bounds, contents等(可以在API文档中搜索:CALayer Animatable Properties).
	
	2>添加动画对象到层(CALayer)中，开始执行动画。通过调用CALayer的addAnimation:forKey:增加动画到层(CALayer)中,这样就能触发动画了.通过调用removeAnimationForKey:可以停止层中的动画.Core Animation的动画执行过程都是在后台操作的,不会阻塞主线程.

####CAAnaimation是个抽象类，不具备动画效果，必须用它的子类才有动画效果。
	所有动画对象的父类,负责控制动画的持续时间和速度,是个抽象类,不能直接使用,应该使用它具体的子类.

	属性解析:

    duration：动画的持续时间 .

    repeatCount：动画的重复次数 .

    repeatDuration：动画的重复时间 .

    removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards .

    fillMode：决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后 .

    beginTime：可以用来设置动画延迟执行时间，若想延迟2s，就设置为CACurrentMediaTime()+2，CACurrentMediaTime()为图层的当前时间 .

    timingFunction：速度控制函数，控制动画运行的节奏 .

 delegate：动画代理
 
	@interface NSObject <CAAnimationDelegate>
	
	//动画开始了
    - (void)animationDidStart:(CAAnimation *)anim;
    
	//动画结束了
    - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

    @end
    
 速度控制函数(CAMediaTimingFunction)

    1> kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉

    2> kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开

    3> kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地

    4> kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。        这个是默认的动画行为。
    CAAnimation在分类中定义了代理方法

   
fillMode属性值（要想fillMode有效，最好设置removedOnCompletion=NO）

    kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态 .

    kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态.
    
    kCAFillModeBackwards 在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始. 你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态  

    kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状。

###　　2.1 CAPropertyAnimation 
		CAPropertyAnimation也是个抽象类，本身不具备动画效果，只有子类才有。
####　　2.1.1 CABasicAnimation 
		
		
####　　2.1.2 CAKeyframeAnimation 	
###　　2.2 CAAnimationGroup
		

###　　2.3 CATransition
