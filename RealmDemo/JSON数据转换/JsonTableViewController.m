//
//  JsonTableViewController.m
//  RealmDemo
//
//  Created by 123456 on 17/3/9.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "JsonTableViewController.h"
#import "MCEpisode.h"

#import <Realm/Realm.h>
#import "RLMObject+JSON.h"

#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "ShowCell.h"

@interface JsonTableViewController ()
@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation JsonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    [self reloadData];
    id primaryKeyValue = [MCEpisode primaryKey];
    NSLog(@"primaryKeyValue-------:%@", primaryKeyValue);
    
}

- (void)sortData {
    self.results = [[MCEpisode allObjects] sortedResultsUsingKeyPath:@"title" ascending:YES];
    [self.tableView reloadData];
}

- (void)reloadData {
    /**
     *  Description 如果缓存中有数据，读取缓存；否则重新获取数据并缓存
     *
     */
    if ([MCEpisode allObjects].count != 0) {
        [self sortData];
    }else {
        _manager = [AFHTTPSessionManager manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", @"application/x-javascript", nil];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        [_manager GET:@"https://www.nsscreencast.com/api/episodes.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *array = responseObject[@"episodes"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[RLMRealm defaultRealm] beginWriteTransaction];
                [MCEpisode createOrUpdateInRealm:[RLMRealm defaultRealm] withJSONArray:array];
                [[RLMRealm defaultRealm] commitWriteTransaction];
                [self sortData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error-------:%@", error);
        }];
    }
    
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

@end
