//
//  AppDelegate.m
//  RealmDemo
//
//  Created by 123456 on 17/2/22.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>
#import "Person.h"
#import "MCEpisode.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

        
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self migrateSource];

    return YES;
}




- (void)migrateSource {
    //数据迁移
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 1;//（如果之前从未设置过架构版本，那么这个版本号设置为 0）
    
    //该方法只能写一次，否则最后写的一次会覆盖前面写的，所以，应该将所有要迁移的数据对应的模型都写在这里，例如Person、MCEpisode
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        
#pragma - 针对Person模型
        [migration enumerateObjects:Person.className
                              block:^(RLMObject *oldObject, RLMObject *newObject) {
                                  //当修改模型中的字段名字时，进行数据迁移
//                                  if (oldSchemaVersion < 1) {
//                                      newObject[@"sex"] = @"";
//                                  }
                              }];
        
#pragma - 针对MCEpisode模型
        [migration enumerateObjects:MCEpisode.className
                              block:^(RLMObject *oldObject, RLMObject *newObject) {
                                  //当修改模型中的字段名字时，进行数据迁移
//                                  if (oldSchemaVersion < 1) {
//                                      [migration renamePropertyForClass:Person.className oldName:@"name" newName:@"title"];
//                                  }
                                  
                                  //当模型中添加新的属性时，进行数据迁移
//                                  if (oldSchemaVersion < 1) {
//                                      newObject[@"hls_url"] = @"";
//                                  }

//                                  if (oldSchemaVersion < 2) {
//                                      newObject[@"video_url"] = @"";
//                                  }
//                                  if (oldSchemaVersion < 3) {
//                                      newObject[@"web_url"] = @"";
//                                  }
////
//                                  if (oldSchemaVersion < 4) {
//                                      newObject[@"slug"] = @"";
//                                  }
                                  
                                  
                                  
                                  
                              }];
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    //现在我们已经成功更新了架构版本并且提供了迁移闭包，打开旧有的 Realm 数据库会自动执行此数据迁移，然后成功进行访问
    [RLMRealm defaultRealm];
}

#pragma mark- 需要时可以在指定版本中将数据删除
- (void)deleteObjects {
        [[RLMRealm defaultRealm] deleteObjects:[MCEpisode allObjects]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
