//
//  DatabaseConfig.h
//  RealmDemo
//
//  Created by 123456 on 17/2/24.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface DatabaseConfig : NSObject
+ (void)setDefaultRealmForUser:(NSString *)username;
+ (RLMRealm *)getRealmOfUser:(NSString *)username;
@end




