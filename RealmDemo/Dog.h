//
//  Dog.h
//  RealmDemo
//
//  Created by 123456 on 17/2/22.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Realm/Realm.h>
@class Person;

@interface Dog : RLMObject
@property NSString *name;
@property Person *owner;
//@property NSNumber<RLMInt> *age;
@property NSInteger age;
@end

RLM_ARRAY_TYPE(Dog)
