# DpWeibo
模仿新浪微博做的一个ios客户端,仅供学习！

![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo09.gif)




## 必读！！
**请把项目中的 `DpWeibo.pch` 中的 `clientId` 和 `redirectUri` 更换成你自己的，如果没有，上 [新浪微博开放平台](http://open.weibo.com/) 创建一个应用，然后填过来！**
=======
## 注意！！
**请把项目中的 `DpWeibo.pch` 中的 `clientId` 和 `redirectUri` 更换成你自己的，如无则请上 [新浪微博开放平台](http://open.weibo.com/) 创建一个应用，然后填过来！**


## 介绍

仅供学习和参考哈！欢迎 star ⭐️ 和 fork！

这是参照新浪微博ios 5.5的样式做的，有基本的查看，转发，评论微博，微博详情等功能，还增加3dtouch的支持。

写这个项目的时候还是个ios新手(刚从.net转过来)，所以项目中有很多不完善和可改进之处，欢迎 fork 继续开发！

如果你有其他建议和意见，请点击 [Issure](https://github.com/zdpdsy/DpWeibo/issues/new)！


> 在 DpWeibo.pch文件中，你可以更换成自己的 OAuth2 认证相关的 Authorize 及 Token。
>
> 如果你没有账号，点击 [新浪微博开放平台](http://open.weibo.com/) 申请一个即可 :)



## 实现功能

1. 新浪微博 OAuth2 认证流程！
2. 完整项目框架：UITabBarController + UINavigationController + UIViewController！

3. 高度自定义 DpTabBarController，实现了 tabBar 的全部自定义。tabBar 中间添加 ➕ 按钮，可随意调整图片位置和大小，随意调整文字位置和大小，并利用 KVO 实现自定义 badgeValue 跟随 tabBarItem.badgeValue 值变化而变化！
4. 实现底部首页，消息，发现，我,新特性5个模块的UI!
5. 实现首页数据的全部展示，包括微博的用户头像、用户名、会员等级图标、时间、发送来源、正文、附图、转发数、评论数、点赞数等！
6. 实现微博的详情页，以及底部的转发，评论，点赞列表，同时也支持手势跳转。
7. 微博附图实现九宫格布局，并可点开查看大图！
8. 实现转发,发送，评论功能！
9. 借鉴 MVVM 思想，实现 cell 的动态高度！
10. 实现下拉刷新和上拉加载功能！
11.增加3dtouch功能，可以进入发送微博和扫码界面，同时可以预览微博的详情页
3. 高度自定义 DpTabBarController，实现了 tabBar 的全部自定义。
4. 实现底部首页，消息，发现，我,新特性5个模块的UI!
5. 封装http请求层，提供一个tools业务类，负责所有的读写数据操作!
6. 实现首页数据的全部展示，包括微博的用户头像、用户名、会员等级图标、时间、发送来源、正文、附图、转发数、评论数、点赞数等！
7. 实现微博的详情页，以及底部的转发，评论，点赞列表，同时也支持手势跳转。
8. 微博附图实现九宫格布局，并可点开查看大图！
9. 实现转发,发送，评论功能！
10. 借鉴 MVVM 思想，实现 cell 的动态高度！
11. 实现下拉刷新和上拉加载功能！
12. 增加3dtouch功能，可以进入发送微博和扫码界面(扫码需真机运行)，同时可以预览微博的详情页!

>>>>>>> origin/master





## 预览


![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo01.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo02.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo03.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo04.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo05.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo06.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo07.jpg)
---
![DpWeibo](https://github.com/zdpdsy/DpWeibo/blob/master/demo08.jpg)

![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo01.jpg)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo02.jpg)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo03.jpg)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo04.png)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo05.png)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo06.png)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo07.png)
---
![DpWeibo](https://raw.githubusercontent.com/zdpdsy/DpWeibo/master/demo08.png)



## 鸣谢

本项目中使用到了如下框架：

* [MJRefresh](https://github.com/CoderMJLee/MJRefresh)
* [MJExtension](https://github.com/CoderMJLee/MJExtension)
* [MJPhotoBrowser](https://github.com/CoderMJLee)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [SDWebImage](https://github.com/rs/SDWebImage)
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD)




## 免责声明

**本项目所用新浪微博接口由新浪微博所有，OAuth2 认证接口由本人所有。**

**仅供学习参考，作者本人保留其他所有未经声明的合法权利。**

**如果你有任何非法行为，如：恶意目的的、对新浪微博造成任意形式损害的... 都与本人无关！**
