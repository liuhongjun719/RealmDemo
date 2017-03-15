//
//  Person.h
//  RealmDemo
//
//  Created by 123456 on 17/2/22.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Realm/Realm.h>
//#import "Dog.h"

@interface Person : RLMObject
@property NSString *name;
@property NSString *date;
@property NSDate *birthdate;
@property NSString *age;

//@property NSString *sex;
//@property NSString *address;
//@property RLMArray<Dog *><Dog> *dogs;

//@property NSInteger id;
//@property NSInteger temID;
//@property NSString *firstName;
//@property NSString *lastName;
//@property NSInteger age;
@end

RLM_ARRAY_TYPE(Person)
