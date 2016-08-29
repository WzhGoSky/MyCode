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
### Core Animation 机构图

![images](https://github.com/WzhGoSky/MyCode/blob/master/imgaes/%E5%8A%A8%E7%94%BB/1.png)


###　　2.1隐式动画
###　　2.2隐式动画
###　　2.3隐式动画
###　　2.4隐式动画