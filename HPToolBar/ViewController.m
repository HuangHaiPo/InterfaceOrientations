//
//  ViewController.m
//  HPToolBar
//
//  Created by 黄海泼 on 2019/1/29.
//  Copyright © 2019 Chris·huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) HPInputView *inputView;
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"屏幕旋转";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self tableView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,100,100 , 200);
    [button setTitle:@"横屏" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:button];
    
}
- (void) buttonClick {
    NSNumber *orientation = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
    [[UIDevice currentDevice] setValue:orientation forKey:@"orientation"];
}
//- (BOOL) shouldAutorotate{
//    return NO;
//}
//- (UIInterfaceOrientationMask) supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"屏幕旋转";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[NSClassFromString(@"HPRotating2ViewController") new] animated:YES];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end


@interface HPInputView ()<UITextFieldDelegate>

@property (nonatomic ,strong) UITextField *noteTextField;

@end

@implementation HPInputView

static HPInputView *_inputView = nil;

+ (instancetype)sharedHPInputView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _inputView = [[HPInputView alloc]init];
    });
    return _inputView;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _inputView = [super allocWithZone:zone];
    });
    return _inputView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self noteTextField];
    }
    return self;
}

- (UITextField *)noteTextField{
    if (!_noteTextField) {
        _noteTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame), 35)];
        _noteTextField.leftViewMode = UITextFieldViewModeAlways;
        _noteTextField.font = [UIFont systemFontOfSize:13];
        _noteTextField.layer.borderWidth = 1.0f;
        _noteTextField.layer.borderColor = [UIColor redColor].CGColor;
        _noteTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _noteTextField.delegate = self;
        _noteTextField.placeholder = @"请输入笔记";
        _noteTextField.backgroundColor = [UIColor whiteColor];
        [self addSubview:_noteTextField];
    }
    return _noteTextField;
}
@end
