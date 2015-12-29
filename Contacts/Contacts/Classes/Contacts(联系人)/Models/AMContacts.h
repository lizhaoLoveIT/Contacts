//
//  AMContacts.h
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMContacts : NSObject

/** 姓名 */
@property (strong, nonatomic) NSString *name;

/** 电话 */
@property (strong, nonatomic) NSString *phoneNumber;

/**
 * 初始化方法
 */
- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber;



@end
