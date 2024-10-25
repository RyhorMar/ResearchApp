//
//  User.m
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

#import <Foundation/Foundation.h>
#import "User.h"

@implementation User

- (nonnull id)copyWithZone:(nullable NSZone *)zone { 
    User *user = [[self.class allocWithZone:zone] init];
    user->_userId = self.userId;
    user->_name = self.name;
    user->_age = self.age;
    user->_email = self.email;
    user->_categories = self.categories;

    return user;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;

    _userId = dictionary[@"id"];
    _name = dictionary[@"name"];
    _age = dictionary[@"age"];
    _email = dictionary[@"email"];
    _categories = dictionary[@"categories"];

    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey { 
    return @{
        @"userId"     : @"id",
        @"name"       : @"name",
        @"age"        : @"age",
        @"email"      : @"email",
        @"categories" : @"categories"
    };
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error { 
    User *user = [[User alloc] initWithDictionary:dictionaryValue];
    return user;
}

+ (NSSet *)propertyKeys { 
    return [NSSet setWithArray: @[
        @"userId",
        @"name",
        @"age",
        @"email",
        @"categories"
    ]
    ];
}

- (BOOL)validate:(NSError *__autoreleasing *)error { 
    return [super validate:error] && self.name.length > 0 && self.age > 0;
}

@end

