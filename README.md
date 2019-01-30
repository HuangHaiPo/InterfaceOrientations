# InterfaceOrientations
横竖屏切换
> 需求:播放视频时横竖屏都可以记笔记，所以用到横竖屏。

前提：想要某个页面或者功能可以横竖屏切换，前提是项目支持横竖屏不然强制横屏也没用。
project > TARGETS > Gengral > Deployment Info > Device Orientation 
 ![](media/15487322177698/15487460498233.jpg)

是否可以旋转主要由下面这三个方法控制
`- (BOOL) shouldAutorotate;` 
`- (UIInterfaceOrientationMask) supportedInterfaceOrientations;` 
`- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;`


### 一.  shouldAutorotate(是否支持自动旋转)
```
- (BOOL) shouldAutorotate{
    return YES;
}
```

>shouldAutorotate作用是调用这个方法的控制器是否支持自动旋转，使用这个方法前提是需要项目支持横屏,返回值是BOOL。

**情景:**
1. NO 当前页面不可以自动横屏，手机竖屏锁在打开或者关闭，调用强制横屏方法无用,不可以横屏。

```
//手机强制横屏方法
NSNumber *orientation = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
[[UIDevice currentDevice] setValue:orientation forKey:@"orientation"];
```
2. YES 当前页面支持自动旋转，手机竖屏锁打开，不可以根据手机方向旋转，调用强制横屏方法页面可以横屏。
3. YES 手机竖屏锁关闭，屏幕可以根据手机朝向旋转，也可以强制旋转。 

### 二.  supportedInterfaceOrientations(当前屏幕支持的方向)
```
- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
```

>supportedInterfaceOrientations作用是屏幕支持的方向有哪些，这个方法返回值是个枚举值`UIInterfaceOrientationMask`具体值有下面

```
typedef NS_OPTIONS(NSUInteger, UIInterfaceOrientationMask) {
    //向上为正方向的竖屏
    UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
    //向左移旋转的横屏
    UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
    //向右旋转的横屏
    UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
    //向下为正方向的竖屏
    UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
    //向左或者向右的横屏
    UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
    //所有的横竖屏方向都支持
    UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
    //支持向上的竖屏和左右方向的横屏
    UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
} __TVOS_PROHIBITED;
```
### 三. preferredInterfaceOrientationForPresentation
> preferredInterfaceOrientationForPresentation 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）返回值是UIInterfaceOrientation是个枚举值
```
typedef NS_ENUM(NSInteger, UIInterfaceOrientation) {
    //屏幕方向未知
    UIInterfaceOrientationUnknown            = UIDeviceOrientationUnknown,
    //向上正方向的竖屏
    UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
    //向下正方向的竖屏
    UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
    //向右旋转的横屏
    UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
    //向左旋转的横屏
    UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
} __TVOS_PROHIBITED;
```

### 四. 具体实现

以上三个方法如果是在随便写的一个demo中完全OK，但是要是在完整项目中，会无效。

**原因:**
测试结果是当前控制器(页面)是否支持旋转是由根视图控制器控制的也就是`rootViewController`，跟视图控制器如果没有重写上面三个方法默认是支持自动旋转的。因为随便写的demo里面的ViewControl就是根视图控制器所以有效。

一般情况下我们的根视图控制器要么是navigationController要么是tabbarController也有ViewControl。所以我们在根视图控制器下重写上面三个方法，把是否支持横竖屏给需要横竖屏的页面控制器来控制,或者写一个category。

下面是navigationController重写的方法其他的一样
##### 1. 导航根视图控制器
**导航根视图控制器下重写方法:**
```
#import "HPNavigationController.h"

@implementation HPNavigationController


- (BOOL) shouldAutorotate{
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);

    return [self.visibleViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return [self.visibleViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}


@end
```

**category重写方法:**
```
#import "UINavigationController+HPToolBar.h"

@implementation UINavigationController (HPToolBar)

- (BOOL) shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.topViewController;
}


@end
```

##### 1. tabBar根视图控制器

**tabBar根视图控制器下重写方法:**

```
#import "HPUITabBarController.h"

@implementation HPUITabBarController


- (BOOL) shouldAutorotate{
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}


@end
```

**category重写方法:**

```
#import "UITabBarController+HPToolBar.h"

@implementation UITabBarController (HPToolBar)


// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController shouldAutorotate];
    } else {
        return [vc shouldAutorotate];
    }
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController supportedInterfaceOrientations];
    } else {
        return [vc supportedInterfaceOrientations];
    }
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController preferredInterfaceOrientationForPresentation];
    } else {
        return [vc preferredInterfaceOrientationForPresentation];
    }
}


@end

```
**ViewController根视图控制器 category重写方法**
```
#import "UIViewController+HPToolBar.h"

@implementation UIViewController (HPToolBar)


// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
```

写过这三个方法后就可以在需要旋转的控制器下重写这三个方法，可以实现自动旋转或者强制旋转,不过强制旋转的前提是`shouldAutorotate`这个方法的返回值为`YES`不然强制旋转无效。上面的执行顺序是先找根视图下的方法，如果有会直接回调。如果没有会找有没有navigationController的类别，有就回调，没有就直接默认为YES。如果根视图控制器没有这重写这三个方法，会找当前ViewControll继承的视图父类或者类别。在把横屏配置打开情况下如果没有重写这三个方法页面只支持竖屏(实测)。如果想要某个页面支持旋转只需要在支持旋转的控制下重写这三个方法。

有关`shouldAutorotate`调用没反应的问题上面有解释，是因为视图是否旋转是由根视图控制器控制，只要重写了上面的方法，就没问题。
