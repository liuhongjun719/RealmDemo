//
//  SomeClass.m
//  RealmDemo
//
//  Created by 123456 on 17/2/23.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "SomeClass.h"
#import <Realm/Realm.h>

@implementation SomeClass
+ (void)setDefaultRealmForUser:(NSString *)username {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    // 使用默认的目录，但是使用用户名来替换默认的文件名
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:username] URLByAppendingPathExtension:@"realm"];
    
     // 将这个配置应用到默认的 Realm 数据库当中
    [RLMRealmConfiguration setDefaultConfiguration:config];
}
@end
