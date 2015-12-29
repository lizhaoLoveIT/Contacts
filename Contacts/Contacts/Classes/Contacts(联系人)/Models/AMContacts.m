//
//  AMContacts.m
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMContacts.h"

@interface AMContacts ()<NSCoding>

@end

@implementation AMContacts

static NSString *keyName = @"keyName";
static NSString *keyPhoneNumber = @"keyPhoneNumber";

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber
{
    if (self = [super init]) {
        self.name = name;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

// 实现归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:keyName];
    [aCoder encodeObject:self.phoneNumber forKey:keyPhoneNumber];
}

// 实现解档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:keyName];
        self.phoneNumber = [aDecoder decodeObjectForKey:keyPhoneNumber];
    }
    return self;
}

@end
