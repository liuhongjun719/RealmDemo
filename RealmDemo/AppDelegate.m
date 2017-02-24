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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
//    config.schemaVersion = 1;
//    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
//        if (oldSchemaVersion < 1) {
//            [migration renamePropertyForClass:Person.className oldName:@"name" newName:@"title"];
//        }
//    };
//    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    
    //数据迁移
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // enumerateObjects:block: 遍历了存储在 Realm 文件中的每一个“Person”对象
        [migration enumerateObjects:Person.className
                              block:^(RLMObject *oldObject, RLMObject *newObject) {
                                  // 只有当 Realm 数据库的架构版本为 0 或者 1 的时候，才添加“email”属性
//                                  if (oldSchemaVersion < 1) {//当Person中新添加了date属性时，进行数据迁移
//                                      newObject[@"date"] = @"";
//                                  }
                              }];
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    // 现在我们已经成功更新了架构版本并且提供了迁移闭包，打开旧有的 Realm 数据库会自动执行此数据迁移，然后成功进行访问
    [RLMRealm defaultRealm];
    

    
    
    return YES;
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
