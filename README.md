百思不得姐项目
===========================
本项目本着能用`代码`用代码的思想敲一遍，做好`笔记`，方便自我`回顾`和提高

****
###　　　　　　　　　　　　Author:Leo
###　　　　　　　　　 E-mail:493852107@qq.com

===========================



##<a name="index"/>目录
* [知识点01](#point01)
	* tabbar封装思想(略)
	* tabbar图片点击颜色
	* 设置导航栏左边的按钮
	* 设置导航栏右边的按钮组
	* UIView+JSExtension
	* 通过 appearance 统一设置所有 UITabBarItem 的文字属性(tabbar文字颜色)

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

* 设置导航栏左边的按钮
	* 封装了 `UIBarButtonItem` UIBarButtonItem+JSExtension 调用
	```objective-c
	+ (instancetype)initWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;  

	self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
	```
* 设置导航栏右边的按钮组
	```objective-c
    self.navigationItem.rightBarButtonItems = @[settingButton, moonButton];
    ```

* UIView+JSExtension
	* 在分类中声明 @property ，只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量  
	```objective-c
	@property (nonatomic, assign) CGSize size;
	```
* 通过 appearance 统一设置所有 UITabBarItem 的文字属性
	* 后面带有 UI_APPEARANCE_SELECTOR 的方法，都可以通过 appearance 对象来统一设置
	```objective-c
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    ```


##<a name="findMoreAboutMarkDown"/>更多MarkDown语法
[README更多语法](https://github.com/guodongxiaren/README "README更多语法")


