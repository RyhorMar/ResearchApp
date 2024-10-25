//
//  User.h
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

#import <Mantle/Mantle.h>

// Model class. We use it out of storage
@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSArray<NSString *> *categories;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
