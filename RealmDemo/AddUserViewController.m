//
//  AddUserViewController.m
//  RealmDemo
//
//  Created by 123456 on 17/2/24.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "AddUserViewController.h"
#import "Person.h"

@interface AddUserViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addOrUpdateButton;

@end

@implementation AddUserViewController


- (IBAction)createPersonAction:(id)sender {
    [self.view endEditing:YES];

    
    if (self.userType == UserTypeAdd) {//添加
        Person *person = [[Person alloc] init];
        person.name = self.nameTextField.text;
        person.age = self.ageTextField.text;
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:person];
        [realm commitWriteTransaction];
    }else {//更新
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        self.person.name = self.nameTextField.text;
        self.person.age = self.ageTextField.text;
        [realm commitWriteTransaction];
    }

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.nameTextField becomeFirstResponder];

    if (self.userType == UserTypeAdd) {
        [self.addOrUpdateButton setTitle:@"添加" forState:UIControlStateNormal];
        self.nameTextField.text = @"";
        self.ageTextField.text = @"";
    }else {
        [self.addOrUpdateButton setTitle:@"更新" forState:UIControlStateNormal];
        self.nameTextField.text = self.person.name;
        self.ageTextField.text = self.person.age;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
