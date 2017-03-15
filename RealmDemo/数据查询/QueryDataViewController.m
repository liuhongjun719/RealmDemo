//
//  QueryDataViewController.m
//  RealmDemo
//
//  Created by 123456 on 17/3/14.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "QueryDataViewController.h"
#import "Person.h"
#import "DatabaseConfig.h"

#import "MCEpisode.h"

#import <Realm/Realm.h>
#import "RLMObject+JSON.h"

#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "ShowCell.h"

@interface QueryDataViewController ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) RLMResults *results;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation QueryDataViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.searchTextField.delegate = self;
    

//    _realm = [DatabaseConfig getRealmOfUser:@"222"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    self.results = [MCEpisode allObjects];
//    [self.tableView reloadData];
    [self sortData];
    
}

- (void)sortData {
    self.results = [[MCEpisode allObjects] sortedResultsUsingKeyPath:@"title" ascending:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    MCEpisode *episode = self.results[indexPath.row];
    cell.title.text = episode.title;
    cell.subtitle.text = episode.subtitle;
    [cell.photo setImageWithURL:[NSURL URLWithString:episode.small_artwork_url] placeholderImage:nil];
    return cell;
}


#pragma mark- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *resultingString = [textField.text stringByReplacingCharactersInRange: range withString: string];
    self.results = [MCEpisode objectsWithPredicate:[NSPredicate predicateWithFormat:@"title CONTAINS %@", self.searchTextField.text]];
    [self.tableView reloadData];
    
    if (resultingString.length == 0) {
        [self.view endEditing:YES];
        textField.text = @"";
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
