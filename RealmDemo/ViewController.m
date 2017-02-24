//
//  ViewController.m
//  RealmDemo
//
//  Created by 123456 on 17/2/22.
//  Copyright © 2017年 123456. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Dog.h"
#import <Realm/Realm.h>
#import "Duck.h"
#import "NextPageViewController.h"
#import "Book.h"
#import "City.h"

@interface ViewController ()<RLMCollection>

@end

@implementation ViewController
- (IBAction)nextPageAction:(id)sender {
    NextPageViewController *nextController = [[NextPageViewController alloc] init];
    [self.navigationController pushViewController:nextController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    Person *jim = [[Person alloc] init];
    Dog *rex = [[Dog alloc] init];
    rex.owner = jim;
    
    RLMResults<Dog *> *someDogs = [Dog objectsWhere:@"name contains 'Fido'"];
    [jim.dogs addObjects:someDogs];
    [jim.dogs addObject:rex];
    
    //update
    Dog *myDog = [[Dog alloc] init];
    myDog.name = @"小白";
//    myDog.age = 1;
    
    //save
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addObject:myDog];
    }];
    
    //get
    Dog *myPuppy = [[Dog objectsWhere:@"name == '小白'"] firstObject];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        myPuppy.name = @"嘿嘿";
    }];
    NSLog(@"name=====:%@", myDog.name);
//    [[Dog objectsWhere:@"name == '小白'"] count];
    NSLog(@"count-----:%lu", (unsigned long)[[Dog objectsWhere:@"name == '小白'"] count]);
    
    
    Duck *duck = [[Duck alloc] initWithValue:@{@"animal": @{@"age":@(3)}, @"name": @"Gustav"}];
    
    
    
    RLMResults<Dog *> *dogs = [Dog allObjects];
    
    [self createModel];
    [self addModel];
    
}

- (void)createModel {
    Dog *myDog = [[Dog alloc] init];
    myDog.name = @"大黄";
    myDog.age = 10;
    
    
    Dog *myOtherDog = [[Dog alloc] initWithValue:@{@"name":@"豆豆", @"age":@3}];
    
    Dog *myThirdDog = [[Dog alloc] initWithValue:@[@"豆豆1", @4]];
}

- (void)addModel {
    Person *author = [[Person alloc] init];
    author.name = @"hhhhhhhhh";
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:author];
    [realm commitWriteTransaction];
}

- (void)updateModel {
    Book *cheeseBook = [[Book alloc] init];
    cheeseBook.title = @"kkkkkkk";
    cheeseBook.price = @90000;
    cheeseBook.id = @1;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [Book createOrUpdateInRealm:realm withValue:cheeseBook];
    [realm commitWriteTransaction];
    
    
    [realm beginWriteTransaction];
    [Book createOrUpdateInRealm:realm withValue:@{@"id":@1, @"price":@9000}];
    [realm commitWriteTransaction];
    
    
//    [realm deleteAllObjects];
}

- (void)predicateModel {
    RLMResults<Dog *> *tanDogs = [Dog objectsWhere:@"color = '棕黄色' AND name BEGINSWITH '大'"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"color = %@ AND name BEGINSWIT %@", @"棕黄色", @"大"];
    tanDogs = [Dog objectsWithPredicate:pred];
}


- (void)sortModel {
    RLMResults<Dog *> *sortedDogs = [[Dog objectsWhere:@"color = '棕黄色' AND name BEGINSWITH '大'"] sortedResultsUsingProperty:@"name" ascending:YES];
}

- (void)chainRequireModel {
    RLMResults<Dog *> *tanDogs = [Dog objectsWhere:@"color = '棕黄色'"];
    RLMResults<Dog *> *tanDogsWithBNames = [tanDogs objectsWhere:@"name BEGINSWITH '大'"];
}

- (void)limitRequireResultModel {
    RLMResults<Dog *> *dogs = [Dog allObjects];
    for (NSInteger i = 0; i < 5; i ++) {
        Dog *dog = dogs[i];
    }
}

- (void)jsonModel {
    NSData *data =  [@"{\"name\": \"旧金山\", \"cityId\": 123}" dataUsingEncoding: NSUTF8StringEncoding];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        [City createOrUpdateInRealm:realm withValue:json];
    }];
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

























