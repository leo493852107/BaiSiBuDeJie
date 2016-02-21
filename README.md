百思不得姐项目
===========================
本项目本着能用`代码`用代码的思想敲一遍，做好`笔记`，方便自我`回顾`和提高

****
###　　　　　　　　　　　　Author:Leo
###　　　　　　　　　 E-mail:493852107@qq.com

===========================



##<a name="index"/>目录
* [知识点01](#point01)
	* tabbar封装思想
	* tabbar图片点击颜色
	* tabbar文字颜色


<a name="point01"/>
###知识点01
* tabbar图片点击颜色
	* 设置点击图片颜色方法1:  
	```objective-c
	UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
	    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	    essence.tabBarItem.selectedImage = image;
	```  
	* 方法2:  
	素材 -> 高亮图片组 -> Render As -> Original Image


##<a name="findMoreAboutMarkDown"/>更多MarkDown语法
[README更多语法](https://github.com/guodongxiaren/README "README更多语法")


