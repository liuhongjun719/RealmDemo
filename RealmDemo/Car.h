//
//  Car.h
//  RealmDemo
//
//  Created by 123456 on 17/2/23.
//  Copyright © 2017年 123456. All rights reserved.
//

#import <Realm/Realm.h>

@interface Car : RLMObject
///<d properties here to define the model
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Car *><Car>
RLM_ARRAY_TYPE(Car)
