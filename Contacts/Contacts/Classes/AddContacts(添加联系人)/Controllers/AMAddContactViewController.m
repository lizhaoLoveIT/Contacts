//
//  AMAddContactViewController.m
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMAddContactViewController.h"

#import "AMContacts.h"

@interface AMAddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumberTextField;

@property (weak, nonatomic) IBOutlet UIButton *addContactButton;

@end

@implementation AMAddContactViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 弹出姓名编辑框
    [self.contactNameTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 设置导航栏按钮
    [self setupNavigationItem];
    
    // 配置 textField 的代理
    [self.contactNameTextField addTarget:self action:@selector(contactsShouldBeAdd) forControlEvents:UIControlEventEditingChanged];
    [self.contactPhoneNumberTextField addTarget:self action:@selector(contactsShouldBeAdd) forControlEvents:UIControlEventEditingChanged];
   
    
    
    [self contactsShouldBeAdd];
    
}

#pragma mark - 初始化设置


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
    [self dismissViewControllerAnimated:YES completion:^{
        [self.view endEditing:YES];
    }];
}

/**
 * 判断联系人是否应该添加
 */
- (void)contactsShouldBeAdd
{
    self.addContactButton.enabled = self.contactNameTextField.hasText && self.contactPhoneNumberTextField.hasText;
}

#pragma mark - 点击屏幕取消编辑状态
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 点击了添加联系人按钮

- (IBAction)clickAddButton {
    
    AMContacts *contact = [[AMContacts alloc] initWithName:self.contactNameTextField.text phoneNumber:self.contactPhoneNumberTextField.text];
    
    if (self.block != nil) {
        self.block(contact);
    }
    // 销毁添加联系人控制器
    [self dismissViewControllerAnimated:YES completion:^{
        [self.view endEditing:YES];
    }];
}




@end
