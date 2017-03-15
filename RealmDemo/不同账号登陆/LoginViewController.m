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
#import "MCEpisode.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (IBAction)hideKeyboardAction:(id)sender {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    [self createSeparateDatabase];
    
    UINavigationController *destination = segue.destinationViewController;
    //    NSLog(@"class----:%@", NSStringFromClass([[destination.viewControllers firstObject] class]));
    UIViewController *userListController = [destination.viewControllers firstObject];
    [userListController setValue:self.userNameTextField.text forKey:@"userName"];
    
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (self.userNameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"输入用户名" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        return NO;
    }
    return YES;
}
- (void)createSeparateDatabase {
    [DatabaseConfig setDefaultRealmForUser:self.userNameTextField.text];
}

@end
