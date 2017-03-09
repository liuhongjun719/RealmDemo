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
//#import "Realm+JSON/RLMObject+JSON.h"
#import "RLMObject+JSON.h"

#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface JsonTableViewController ()
@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) RLMNotificationToken *token;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation JsonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.token = [[RLMRealm defaultRealm] addNotificationBlock: ^(NSString *notification, RLMRealm *realm) {
        [self refreshData];
    }];
    [self refreshData];
    [self reloadData];
}

- (void)reloadData {
    
    
    /**
     *  Description
     *
     */
    RLMResults *tmpResults =  [MCEpisode allObjects];
    if (tmpResults.count != 0) {
        self.results = tmpResults;
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
                RLMRealm *realm = [RLMRealm defaultRealm];
                
                [realm beginWriteTransaction];
                NSArray *result = [MCEpisode createOrUpdateInRealm:realm withJSONArray:array];
                [realm commitWriteTransaction];
                
                NSLog(@"result: %@", result);
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error-------:%@", error);
        }];
    }
    
}

- (void)refreshData {
    self.results = [[MCEpisode allObjectsInRealm:[RLMRealm defaultRealm]] sortedResultsUsingProperty:@"publishedDate" ascending:NO];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MCEpisode *episode = self.results[indexPath.row];
    
    cell.textLabel.text = episode.title;
    cell.detailTextLabel.text = [dateFormatter stringFromDate:episode.publishedDate];
//    cell.imageView.image = nil;
//    cell.backgroundColor = episode.episodeType == MCEpisodeTypePaid ? [UIColor colorWithRed:0.996 green:0.839 blue:0.843 alpha:1]: nil;
//    
//    __weak UITableViewCell *weakCell = cell;
//    [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:episode.thumbnailURL]] placeholderImage:nil success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        weakCell.imageView.image = image;
//        [weakCell setNeedsLayout];
//    } failure:nil];
//    
    return cell;
}

@end
