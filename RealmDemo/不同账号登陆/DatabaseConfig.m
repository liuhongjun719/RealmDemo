//
//  DatabaseConfig.m
//  RealmDemo
//
//  Created by 123456 on 17/2/24.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "DatabaseConfig.h"
#import "Person.h"
#import "MCEpisode.h"

@implementation DatabaseConfig


#pragma 对默认的realm进行配置
+ (void)setDefaultRealmForUser:(NSString *)username {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    //允许进行数据迁移的类
//    config.objectClasses = @[Person.class, MCEpisode.class];
    // 使用默认的目录，但是使用用户名来替换默认的文件名
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:username]
                      URLByAppendingPathExtension:@"realm"];
    NSLog(@"url====:%@", config.fileURL);

    // 将这个配置应用到默认的 Realm 数据库当中
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

#pragma 创建自己的Realm(获取指定账号下的数据)
+ (RLMRealm *)getRealmOfUser:(NSString *)username {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:username]
                      URLByAppendingPathExtension:@"realm"];
    NSLog(@"Realm file path: %@", config.fileURL);
    NSError *error;
    return [RLMRealm realmWithConfiguration:config error:&error];
}




@end
