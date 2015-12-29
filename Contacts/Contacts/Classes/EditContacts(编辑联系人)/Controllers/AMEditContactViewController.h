//
//  AMEditContactViewController.h
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMContacts;

typedef void(^AMEditContactViewControllerBlock)(AMContacts *contact);

@interface AMEditContactViewController : UIViewController

/** 编辑联系人 AMEditContactViewController 向联系人 AMContactsViewController 传入要编辑的数据 */
@property (copy, nonatomic) AMEditContactViewControllerBlock block;

/** Contact */
@property (strong, nonatomic) AMContacts *contact;

@end
