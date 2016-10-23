//
//  GLCustomAlertView.h
//  GLAlertView
//
//  Created by 温国力 on 16/10/22.
//  Copyright © 2016年 wgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLCustomAlertViewDelegate

@optional
/**
 点击底部按钮，关闭弹框

 @param alertView   当前显示的alertView
 @param buttonIndex 记录点击哪个按钮
 */
- (void)customIOSdialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface GLCustomAlertView : UIView<GLCustomAlertViewDelegate>

/// 点击按钮点击的代理， 如果使用block，该代理就不用了，二者选一即可！
@property (nonatomic, assign) id<GLCustomAlertViewDelegate> delegate;

/// 添加自定义View添加到dialogView上面
@property (nonatomic, strong) UIView *dialogView;

/// 添加自定义View
@property (nonatomic, strong) UIView *containerView;

/// 添加多个自定义按钮
@property (nonatomic, strong) NSArray *buttonTitles;

/// 蒙板颜色
@property (nonatomic, strong) UIColor *HUDBgColor;

/// 是否隐藏底部的按钮,默认是NO
@property (nonatomic, assign ) BOOL closeButton;

/// 是否点击除了view以外任何地方都消失，默认是NO
@property (nonatomic, assign) BOOL closeOnTouchUpOutside;

/// 是否需要绘制边框，默认NO
@property (nonatomic, assign ) BOOL showShadow;

/// 定义按钮点击回调
@property (copy) void (^onButtonTouchUpInside)(GLCustomAlertView *alertView, int buttonIndex);

/**
 初始化对象

 @return 创建对象
 */
- (instancetype)init;

/**
 显示当前view
 */
- (void)show;

/**
 关闭当前view
 */
- (void)close;

/**
 block回调，监听按钮的点击事件

 @param onButtonTouchUpInside 监听哪个按钮被点击
 */
- (void)setOnButtonTouchUpInside:(void (^)(GLCustomAlertView *alertView, int buttonIndex))onButtonTouchUpInside;

/**
 按钮点击事件

 @param sender 记录点击哪个按钮
 */
- (void)customIOSdialogButtonTouchUpInside:(id)sender;

@end
