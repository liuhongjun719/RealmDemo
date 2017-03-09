//
//  UserListTableViewController.m
//  RealmDemo
//
//  Created by 123456 on 17/2/24.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "UserListTableViewController.h"
#import "Person.h"
#import "AddUserViewController.h"

@interface UserListTableViewController ()<UITableViewDataSource>
//@property (nonatomic, strong) RLMResults *datasource;
@property (nonatomic, strong) RLMResults<Person *> *datasource;
@property (nonatomic, strong) RLMNotificationToken *token;

@end

@implementation UserListTableViewController
- (IBAction)logoutAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)addModelAction:(id)sender {
    Person *person = [[Person alloc] init];
    person.name = self.userName;
    person.date = [self getCurrentDate];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:person];
    [realm commitWriteTransaction];
    [self.tableView reloadData];
    NSLog(@"count----:%lu", (unsigned long)[Person allObjects].count);
}

- (NSString *)getCurrentDate {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasource = [Person allObjects];
    
    //插入或删除数据时，刷新界面
    _token = [[Person allObjects] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to open Realm on background worker: %@", error);
            return;
        }
        [self.tableView reloadData];
    }];
//    [_token stop];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    Person *person = [_datasource objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行 %@ %@", (long)indexPath.row, person.name, person.age];

//    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行 %@ %@", (long)indexPath.row, person.name, person.date];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Person *person = [_datasource objectAtIndex:indexPath.row];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:person];
        [realm commitWriteTransaction];
        
        _datasource = [Person allObjects];
        [self.tableView reloadData];

        
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"des----------:%@",  NSStringFromClass([segue.destinationViewController class]));
    AddUserViewController *destinationController = segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"Add"]) {
        destinationController.userType = UserTypeAdd;
    }else {
        destinationController.userType = UserTypeUpdate;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Person *person = [_datasource objectAtIndex:indexPath.row];
        destinationController.person = person;

    }
}






@end
