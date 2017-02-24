//
//  SomeClass.h
//  RealmDemo
//
//  Created by 123456 on 17/2/23.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SomeClass : NSObject

/**
 *  Realm 配置
 通过RLMRealmConfiguration您可以配置诸如 Realm 文件在何处存储之类的信息。
 
 配置同时也可以在每次您需要使用 Realm 实例的时候传递给[RLMRealm realmWithConfiguration:config error:&err]，或者您也可以通过 [RLMRealmConfiguration setDefaultConfiguration:config] 来为默认的 Realm 数据库进行配置。
 
 比如说，假设有这样一个应用，用户必须登录到您的网站后台才能够使用，然后您希望这个应用支持快速帐号切换功能。 您可以为每个帐号创建一个特有的 Realm 文件，通过对默认配置进行更改，就可以直接使用默认的 Realm 数据库来直接访问了，如下所示：
 *
 *  @param username 用户名
 */
+ (void)setDefaultRealmForUser:(NSString *)username;
@end
