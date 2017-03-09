//
//  LoginViewController.m
//  RealmDemo
//
//  Created by 123456 on 17/2/24.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "LoginViewController.h"
#import "UserListTableViewController.h"
#import "DatabaseConfig.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)loginAction:(id)sender {
//    UserListTableViewController *listController = [[UserListTableViewController alloc] init];
//    [self presentViewController:listController animated:YES completion:nil];
//}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    if (self.userNameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"输入用户名" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        return;
    }
    
    [self createSeparateDatabase];
    
    UINavigationController *destination = segue.destinationViewController;
    NSLog(@"class----:%@", NSStringFromClass([[destination.viewControllers firstObject] class]));
    UIViewController *userListController = [destination.viewControllers firstObject];
    [userListController setValue:self.userNameTextField.text forKey:@"userName"];


    
}
- (void)createSeparateDatabase {
    [DatabaseConfig setDefaultRealmForUser:self.userNameTextField.text];
}

@end
