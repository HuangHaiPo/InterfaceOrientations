//
//  UIViewController+HPToolBar.m
//  HPToolBar
//
//  Created by 黄海泼 on 2019/1/30.
//  Copyright © 2019 Chris·huang. All rights reserved.
//

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
