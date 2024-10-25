//
//  userTests.h
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

#import <XCTest/XCTest.h>
#import "User.h"


@interface userTests : XCTestCase

@end

@implementation userTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInit {
    NSDictionary * json = @{
        @"id": @"1",
        @"name":@"Grigorii",
        @"age": @"45",
        @"email":@"650451@tut.by",
        @"categories":@[
            @"category 1",
            @"category 2"
        ]
    };
    
    User * user = [[User alloc] initWithDictionary:json];
    XCTAssertNotNil(user);
    XCTAssertEqualObjects(user.userId, @"1");
    XCTAssertEqualObjects(user.name, @"Grigorii");
    XCTAssertEqualObjects(user.age, @"45");
    XCTAssertEqualObjects(user.email, @"650451@tut.by");
    XCTAssertEqual(user.categories.count, 2);
}


@end
