//
//  UIView+AMExtension.h
//  百思不得姐
//
//  Created by Ammar on 15/8/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AMExtension)
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

// 注意千万不能改bounse 必须改frame

/** 判断当前view是否显示在主窗口上 */
- (BOOL)isShowingAtKeyWindow;


@end
