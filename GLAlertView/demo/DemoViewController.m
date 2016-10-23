//
//  DemoViewController.m
//  GLAlertView
//
//  Created by 温国力 on 16/10/22.
//  Copyright © 2016年 wgl. All rights reserved.
//

#import "DemoViewController.h"
#import "GLEasyAlertView.h"
#import "GLCustomAlertView.h"

@interface DemoViewController ()<GLCustomAlertViewDelegate>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

#pragma mark - 创建UI
- (void)setupUI
{
    UIButton *easyAlertView = [self createBtn:@"简单动画框"];
    [easyAlertView setFrame:CGRectMake(10, 30, self.view.bounds.size.width-20, 40)];
    [easyAlertView addTarget:self action:@selector(clickShowEasyAlertView) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:easyAlertView];
    
    UIButton *showCustomView = [self createBtn:@"带有按钮动画框"];
    [showCustomView setFrame:CGRectMake(10, 80, self.view.bounds.size.width-20, 40)];
    [showCustomView addTarget:self action:@selector(clickShowCustomAlertViewButton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:showCustomView];
    
    
}
#pragma mark - 创建按钮
- (UIButton *)createBtn:(NSString *)title
{
    // A simple button to launch the demo
    UIButton *showCustomView = [UIButton buttonWithType:UIButtonTypeCustom];
    [showCustomView setTitle:title forState:UIControlStateNormal];
    [showCustomView setBackgroundColor:[UIColor orangeColor]];
    [showCustomView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showCustomView.layer setBorderWidth:0];
    [showCustomView.layer setCornerRadius:5];
    return showCustomView;
}
#pragma mark - 简单动画弹框按钮
- (void)clickShowEasyAlertView
{
    GLEasyAlertView *alertView = [[GLEasyAlertView alloc] init];
    
    //添加自定义View
    [alertView setContainerView:[self createDemoView]];
    
    // 点击除弹框以外，弹框消失
    alertView.closeOnTouchUpOutside = YES;
    
    // 设置蒙板背景色
    alertView.HUDBgColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75f];
    
    // 是否绘制边框
    alertView.showShadow = YES;
    
    //显示弹框
    [alertView show];

}

#pragma mark - 点击自定义的动画弹框按钮
- (void)clickShowCustomAlertViewButton
{
    GLCustomAlertView *alertView = [[GLCustomAlertView alloc] init];
    
    alertView.delegate = self;
    
    //添加自定义View
    [alertView setContainerView:[self createDemoView]];
    
    //添加自定义按钮
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确定",nil]];
    
    // 可以在block里面进行回调，也可以在下面的代理方法中回调
    [alertView setOnButtonTouchUpInside:^(GLCustomAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: 点击了第%d按钮", buttonIndex + 1);
        //关闭弹框
        [alertView close];
    }];
    
    // 点击除弹框以外，弹框消失
//    alertView.closeOnTouchUpOutside = YES;
    
    // 是否隐藏按钮
//    alertView.closeButton = YES;
    
    // 设置蒙板背景色
//    alertView.HUDBgColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75f];
    
    // 是否绘制边框
//    alertView.showShadow = YES;
    
    //显示弹框
    [alertView show];
    
}
#pragma mark - 该代理与以上block是相同的，看个人喜好使用！
- (void)customIOSdialogButtonTouchUpInside: (GLCustomAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: 点击了第%zd按钮", buttonIndex + 1);
    [alertView close];
}
#pragma mark - demo1自定义动画弹框的内容
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 280, 190)];
    
    [imageView setImage:[UIImage imageNamed:@"liuyifei"]];
    
    [demoView addSubview:imageView];
    
    return demoView;
}




@end
