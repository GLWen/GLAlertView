//
//  GLEasyAlertView.m
//  GLAlertView
//
//  Created by 温国力 on 16/10/23.
//  Copyright © 2016年 wgl. All rights reserved.
//

#import "GLEasyAlertView.h"
#import <QuartzCore/QuartzCore.h>

const static CGFloat kCustomIOSAlertViewCornerRadius              = 3;
const static CGFloat kCustomIOSAlertViewBorderWidth               = 0.1;
const static CGFloat kCustomIOSAlertViewShadowRadius              = 8;
const static CGFloat kCustomIOSAlertViewShadowOpacity             = 0.75f;

@implementation GLEasyAlertView

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.showShadow = NO;
    }
    return self;
}

#pragma mark - 显示动画弹框
- (void)show
{
    self.dialogView = [self createContainerView];
    
    self.dialogView.layer.cornerRadius = kCustomIOSAlertViewCornerRadius;
    self.dialogView.layer.shouldRasterize = YES;
    self.dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:self.dialogView];
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    CGSize keyboardSize = CGSizeMake(0, 0);
    
    self.dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // 设置蒙板背景颜色wgl
                         if (self.HUDBgColor !=NULL) {
                             self.backgroundColor = self.HUDBgColor;
                         }else {
                             self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3f];
                         }
                         self.dialogView.layer.opacity = 1.0f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
    
}

#pragma mark - 关闭弹框
- (void)close
{
    CATransform3D currentTransform = self.dialogView.layer.transform;
    
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}


#pragma mark - 自定弹框里面的view以及底部的按钮
- (UIView *)createContainerView
{
    if (self.containerView == NULL) {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
     [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    // 弹框内容
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2, ( screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)];
    
    // 绘制图层
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    // 这里可以自定义弹框颜色，默认使用白色
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor whiteColor] CGColor],
                       (id)[[UIColor whiteColor] CGColor],
                       (id)[[UIColor whiteColor] CGColor],
                       nil];
    CGFloat cornerRadius = kCustomIOSAlertViewCornerRadius;
    gradient.cornerRadius = cornerRadius;
    [dialogContainer.layer insertSublayer:gradient atIndex:0];
    
    // 绘制阴影边框
    if (self.showShadow) {
        dialogContainer.layer.cornerRadius = cornerRadius;
        dialogContainer.layer.borderColor = [[UIColor colorWithRed:238.0/255.0 green:157.0/255.0 blue:33.0/255.0 alpha:1.0f] CGColor];
        dialogContainer.layer.borderWidth = kCustomIOSAlertViewBorderWidth;
        dialogContainer.layer.shadowRadius = kCustomIOSAlertViewShadowRadius;
        dialogContainer.layer.shadowOpacity = kCustomIOSAlertViewShadowOpacity;
        dialogContainer.layer.shadowOffset = CGSizeMake(0 , 0 );
        dialogContainer.layer.shadowColor = [UIColor colorWithRed:238.0/255.0 green:157.0/255.0 blue:33.0/255.0 alpha:1.0f].CGColor;
        dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    }
    
    // 添加自定义view
    [dialogContainer addSubview:self.containerView];
    
    return dialogContainer;
}

#pragma mark - 根据自定义view显示弹框的宽高
- (CGSize)countDialogSize
{
    CGFloat dialogWidth = self.containerView.frame.size.width;
    CGFloat dialogHeight = self.containerView.frame.size.height;
    return CGSizeMake(dialogWidth, dialogHeight);
}

- (CGSize)countScreenSize
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return CGSizeMake(screenWidth, screenHeight);
}

#pragma mark - 监听屏幕点击
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.closeOnTouchUpOutside) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[GLEasyAlertView class]]) {
        [self close];
    }
}




@end
