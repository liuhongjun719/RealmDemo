//
//  Book.h
//  RealmDemo
//
//  Created by 123456 on 17/2/23.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Realm/Realm.h>

@interface Book : RLMObject
@property NSString *title;
@property NSNumber *price;
@property NSNumber *id;
@end
