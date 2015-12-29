//
//  AMLoginViewController.m
//  Contacts
//
//  Created by 李朝 on 15/12/26.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMLoginViewController.h"
#import "AMContactsViewController.h"

#import <SVProgressHUD.h>

@interface AMLoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (weak, nonatomic) IBOutlet UISwitch *keepPasswordSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation AMLoginViewController

static NSString *userAccount = @"userAccount";
static NSString *userPassword = @"userPassword";
static NSString *rememberPassword = @"rememberPassword";
static NSString *autoLogin = @"autoLogin";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置导航控制器
    [self setupNavigationController];
 
    // 配置子控件
    [self setupSubviews];
    
}

/**
 * 配置导航控制器
 */
- (void)setupNavigationController
{
    self.navigationItem.title = @"欢迎来到私人通讯录";
}

/**
 * 配置子控件
 */
- (void)setupSubviews
{
    // 配置 textField 的代理
    [self.userTextField addTarget:self action:@selector(userShouldLogin) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(userShouldLogin) forControlEvents:UIControlEventEditingChanged];
    
    // 取出存储的数据
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    // 记录用户保存的信息
    self.userTextField.text = [userDefault objectForKey:userAccount];
    
    if ((self.keepPasswordSwitch.on = [userDefault boolForKey:rememberPassword])) {
        self.passwordTextField.text = [userDefault objectForKey:userPassword];
    }
    
    // 控制登陆按钮不能输入
    [self userShouldLogin];
    
    if ((self.autoLoginSwitch.on = [userDefault boolForKey:autoLogin])) {
        // 登陆
        [self clickLoginButton];
    }
    
}



#pragma mark - 处理开关的业务逻辑


/**
 * 点击了自动登陆开关
 */
- (IBAction)autoLogin {
    if (self. autoLoginSwitch.isOn) { // 如果自动登陆开关打开了，则
        // 记住密码开关也要打开
        [self.keepPasswordSwitch setOn:YES animated:YES];
    }
}


/**
 * 点击了记住密码开关
 */
- (IBAction)keepPassword {
    if (!self.keepPasswordSwitch.isOn) { // 如果记住密码开关被关上了，则
        // 自动登陆开关也要关闭
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

#pragma mark - 点击屏幕取消编辑状态
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 登陆按钮的业务逻辑
/**
 * 点击了登陆按钮
 */
- (IBAction)clickLoginButton {
    
    // 跳转之前需要判断用户名和密码是否正确
    [SVProgressHUD showWithStatus:@"正在登陆ing..." maskType:(SVProgressHUDMaskTypeGradient)];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.userTextField.text isEqualToString:@"lizhao"] && [self.passwordTextField.text isEqualToString:@"123"]) {
            [SVProgressHUD dismiss];
            // 跳转控制器
            AMContactsViewController *contactsVC = [[AMContactsViewController alloc] init];
            contactsVC.navigationItem.title = [NSString stringWithFormat:@"%@的联系人列表", self.userTextField.text];
            // 将密码和用户名以及登陆状态存储起来
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            [userDefaults setObject:self.userTextField.text forKey:userAccount];
            [userDefaults setObject:self.passwordTextField.text forKey:userPassword];
            [userDefaults setBool:self.keepPasswordSwitch.on forKey:rememberPassword];
            [userDefaults setBool:self.autoLoginSwitch.on forKey:autoLogin];
            
            [self.view endEditing:YES];
            [self.navigationController pushViewController:contactsVC animated:YES];
            
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误" maskType:(SVProgressHUDMaskTypeGradient)];
        }
    });
    
}

/**
 * 是否允许用户登陆
 */
- (void)userShouldLogin
{
    // 登陆按钮在 textField 有文字的时候才可以登陆
    self.loginButton.enabled = self.userTextField.hasText && self.passwordTextField.hasText;
}


@end
