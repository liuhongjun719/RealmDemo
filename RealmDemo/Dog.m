//
//  Dog.m
//  RealmDemo
//
//  Created by 123456 on 17/2/22.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "Dog.h"

@implementation Dog
+ (NSDictionary *)defaultPropertyValues {
    return @{@"name":@"yio"};
}
+ (NSArray *)requiredProperties {
    return @[@"name"];
}
@end
