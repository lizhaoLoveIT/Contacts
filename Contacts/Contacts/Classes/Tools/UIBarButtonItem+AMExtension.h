//
//  UIBarButtonItem+AMExtension.h
//  百思不得姐
//
//  Created by Ammar on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AMExtension)

/** 自定义UIBarButtonItem， 导航栏的按钮图片和点击监听 */
+ (instancetype)barButtonItemWithImageName:(NSString *)imageName andHighlightedImageName:(NSString *)imageNameHighlighted WithTarget:(id)target action:(SEL)aselector;

@end
