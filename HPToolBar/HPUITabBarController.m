//
//  HPUITabBarController.m
//  HPToolBar
//
//  Created by 黄海泼 on 2019/1/30.
//  Copyright © 2019 Chris·huang. All rights reserved.
//

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
