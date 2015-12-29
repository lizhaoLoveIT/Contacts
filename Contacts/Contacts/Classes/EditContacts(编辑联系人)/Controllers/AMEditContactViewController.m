//
//  AMEditContactViewController.m
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMEditContactViewController.h"
#import "AMContacts.h"


@interface AMEditContactViewController ()

@property (weak, nonatomic) IBOutlet UITextField *contactName;

@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation AMEditContactViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.contactName becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupTextField];
    
    [self editButtonShouldBeClick];
}

/**
 * 设置文本框
 */
- (void)setupTextField
{
    [self.contactName addTarget:self action:@selector(editButtonShouldBeClick) forControlEvents:(UIControlEventEditingChanged)];
    [self.contactPhoneNumber addTarget:self action:@selector(editButtonShouldBeClick) forControlEvents:(UIControlEventEditingChanged)];
    
    
    self.contactName.text = self.contact.name;
    self.contactPhoneNumber.text = self.contact.phoneNumber;
}


/**
 * 设置导航栏按钮
 */
- (void)setupNavigationItem
{
    // 左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStyleDone target:self action:@selector(back)];
}

/**
 * 点击了导航栏左侧按钮返回
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 编辑按钮是否可以被点击
- (void)editButtonShouldBeClick
{
    // 取出 contactOldName 和 contactOldPhoneNumber
    NSString *contactOldName = self.contact.name;
    NSString *contactOldPhoneNumber = self.contact.phoneNumber;
    
    self.editButton.enabled = !([self.contactName.text isEqualToString:contactOldName] && [self.contactPhoneNumber.text isEqualToString:contactOldPhoneNumber]);
}

#pragma mark - 点击了编辑按钮 edit
- (IBAction)clickEditButton {
    AMContacts *contact = [[AMContacts alloc] initWithName:self.contactName.text phoneNumber:self.contactPhoneNumber.text];
    
    // 将数据传回联系人界面
    if (self.block != nil) {
        self.block(contact);
    }
    
    // 返回联系人控制器
    [self.navigationController popViewControllerAnimated:YES];
    
}





@end
