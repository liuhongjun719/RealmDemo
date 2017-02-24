//
//  Duck.h
//  RealmDemo
//
//  Created by 123456 on 17/2/23.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Realm/Realm.h>
@class Animal;

@interface Duck : RLMObject
@property Animal *animal;
@property NSString *name;
@end
