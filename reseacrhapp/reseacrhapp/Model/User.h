//
//  User.h
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

#import <Mantle/Mantle.h>

@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSArray *categories;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
