//
//  AMContactsViewController.m
//  Contacts
//
//  Created by 李朝 on 15/12/27.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMContactsViewController.h"
#import "AMAddContactViewController.h"
#import "AMEditContactViewController.h"

#import "AMContacts.h"

@interface AMContactsViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 联系人数组 */
@property (strong, nonatomic) NSMutableArray *Contacts;

@end

@implementation AMContactsViewController

// 存储联系人的文件名
static NSString *contactsFilePathName = @"contacts.data";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏按钮
    [self setupNavigationItem];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 取消 tableViewCell 之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

/**
 * 设置导航栏按钮
 */
- (void)setupNavigationItem
{
    // 左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style: UIBarButtonItemStyleDone target:self action:@selector(clickLeftNavigationItem)];
    
    // 右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightNavigationItem)];

}


#pragma mark - 点击了导航栏的按钮

/**
 * 点击了左侧导航栏按钮
 */
- (void)clickLeftNavigationItem
{
    // 注销 UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要注销吗？" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"注销" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        // 点击了注销回到登陆界面
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:destructiveAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 * 点击了右侧添加按钮
 */
- (void)clickRightNavigationItem
{
    // 跳转添加联系人控制器
    AMAddContactViewController *addVC = [[AMAddContactViewController alloc] initWithNibName:NSStringFromClass([AMAddContactViewController class]) bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addVC];
    
    // 给 addVC 的 block 赋值，告诉它在某一时刻需要做的事情
    addVC.block = ^(AMContacts *contact){
        // 将传过来的 contact 添加到 tableView 上
        [self.Contacts addObject:contact];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 将联系人重新存入数据库
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent: contactsFilePathName];
        
        [NSKeyedArchiver archiveRootObject:self.Contacts toFile:filePath];
    };
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


#pragma mark -  dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.Contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"contact";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
    }
    
    // 添加数据
    if (self.Contacts.count != 0) {
        AMContacts *contact = self.Contacts[indexPath.row];
        cell.textLabel.text = contact.name;
        cell.detailTextLabel.text = contact.phoneNumber;
    }
    return cell;
}

/**
 * 点击 cell 跳转编辑控制器
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMContacts *contact = self.Contacts[indexPath.row];
    // 点击 cell 跳转
    AMEditContactViewController *editVC = [[AMEditContactViewController alloc] initWithNibName:NSStringFromClass([AMEditContactViewController class]) bundle:nil];
    
    __weak typeof(contact) weakContact = contact;
    
    editVC.contact = contact;
    
    editVC.block = ^(AMContacts *contact){
        weakContact.name = contact.name;
        weakContact.phoneNumber = contact.phoneNumber;
        
        // 刷新表格
        [tableView reloadData];
    };
    
    [self.navigationController pushViewController:editVC animated:YES];
}

/**
 * 实现左划删除功能
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 * 在这里修改和实现删除功能和样式
 */
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 拿到当前选中的行，并删除，然后刷新表格
        [self.Contacts removeObjectAtIndex:indexPath.row];
        
        // 删除动画、更新 tableView
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
        
    }];
    action.backgroundColor = [UIColor purpleColor];
    
    return @[action];
}

#pragma mark - 懒加载

/**
 * 创建联系人数组
 */
- (NSMutableArray *)Contacts
{
    if (_Contacts == nil) {
        // 取出联系人文件的联系人展示到 tableView 中去
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:contactsFilePathName];
        _Contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if (_Contacts == nil) {
            // 说明第一次进入通讯录
            _Contacts = [NSMutableArray array];
        }
    }
    
    return _Contacts;
}


@end