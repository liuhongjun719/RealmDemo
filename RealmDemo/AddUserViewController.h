//
//  AddUserViewController.h
//  RealmDemo
//
//  Created by 123456 on 17/2/24.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeAdd = 1, //添加信息
    UserTypeUpdate = 2, //修改信息

};
@interface AddUserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (nonatomic, assign) UserType userType;
@property (nonatomic, strong) Person *person;

@end
