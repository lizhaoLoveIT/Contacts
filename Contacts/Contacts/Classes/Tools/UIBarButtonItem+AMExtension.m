//
//  UIBarButtonItem+AMExtension.m
//  百思不得姐
//
//  Created by Ammar on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIBarButtonItem+AMExtension.h"


@implementation UIBarButtonItem (AMExtension)

+ (instancetype)barButtonItemWithImageName:(NSString *)imageName andHighlightedImageName:(NSString *)imageNameHighlighted WithTarget:(id)target action:(SEL)aselector
{
    // 设置按钮图片
    
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageHighlight = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:imageHighlight forState:UIControlStateHighlighted];
    // 尺寸等于图片尺寸
    CGRect rect = button.frame;
    rect.size = button.currentBackgroundImage.size;
    button.frame = rect;
    [button addTarget:target action:aselector forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到系统的UIBarButtonItem中
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

@end
