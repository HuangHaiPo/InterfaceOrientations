//
//  HPRotating2ViewController.m
//  HPToolBar
//
//  Created by 黄海泼 on 2019/1/29.
//  Copyright © 2019 Chris·huang. All rights reserved.
//

#import "HPRotating2ViewController.h"

@interface HPRotating2ViewController ()
@property (nonatomic ,strong) UITextField *noteTextField;

@end

@implementation HPRotating2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self noteTextField];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100,200,100 , 200);
    [button setTitle:@"横屏" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100,400,100 , 200);
    [button1 setTitle:@"跳转" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:button1];
    
}
- (void) buttonClick {
    NSNumber *orientation = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
    [[UIDevice currentDevice] setValue:orientation forKey:@"orientation"];
}
- (void)jump{
    UIViewController *vc = [UIViewController new];
    [self presentViewController:vc animated:YES completion:nil];
    
    //    [self.navigationController pushViewController:[NSClassFromString(@"HPRotating2ViewController") new] animated:YES];
}
- (UIView *)addToolbar
{
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.backgroundColor = [UIColor blueColor];
    return toolbar;
}
- (UITextField *)noteTextField{
    if (!_noteTextField) {
        _noteTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 70,CGRectGetWidth(self.view.frame), 35)];
        _noteTextField.leftViewMode = UITextFieldViewModeAlways;
        _noteTextField.font = [UIFont systemFontOfSize:13];
        _noteTextField.layer.borderWidth = 1.0f;
        _noteTextField.layer.borderColor = [UIColor redColor].CGColor;
        _noteTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _noteTextField.placeholder = @"请输入笔记";
        _noteTextField.inputAccessoryView = self.addToolbar;
        _noteTextField.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_noteTextField];
    }
    return _noteTextField;
}
- (BOOL) shouldAutorotate{
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);

    return YES;
}
- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
