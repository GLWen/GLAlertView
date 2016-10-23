//
//  GLEasyAlertView.h
//  GLAlertView
//
//  Created by 温国力 on 16/10/23.
//  Copyright © 2016年 wgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLEasyAlertView : UIView

/// 添加自定义View添加到dialogView上面
@property (nonatomic, strong) UIView *dialogView;

/// 添加自定义View
@property (nonatomic, strong) UIView *containerView;

/// 蒙板颜色
@property (nonatomic, strong) UIColor *HUDBgColor;

/// 是否隐藏底部的按钮,默认是NO
@property (nonatomic, assign ) BOOL closeButton;

/// 是否点击除了view以外任何地方都消失，默认是NO
@property (nonatomic, assign) BOOL closeOnTouchUpOutside;

/// 是否需要绘制边框，默认NO
@property (nonatomic, assign ) BOOL showShadow;


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


@end
