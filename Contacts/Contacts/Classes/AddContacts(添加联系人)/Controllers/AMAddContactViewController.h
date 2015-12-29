//
//  AMAddContactViewController.h
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMContacts;

typedef void(^AMAddContactViewControllerBlock)(AMContacts *contact);

@interface AMAddContactViewController : UIViewController

/** 这个 block 用于向 AMContactsViewController 联系人控制器传入新添加的联系人 */
@property (copy, nonatomic) AMAddContactViewControllerBlock block;

@end
