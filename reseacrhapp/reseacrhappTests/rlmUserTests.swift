//
//  rlmUserTests.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

import XCTest

@testable import reseacrhapp

final class rlmUserTests: XCTestCase {
    
    func testInit() {
        let json : [String: Any] = [
            "id": "1",
            "name": "Grigorii",
            "age": "45",
            "email": "650451@tut.by",
            "categories":[
                "category 1",
                "category 2"
            ]
        ]
        let userModel = User(dictionary: json)
        XCTAssertNotNil(userModel)
        guard let user = userModel else {
            XCTFail("Expected non-nil user")
            return
        }
        
        let rlmUser = RLMUser.from(model: user)
        XCTAssertNotNil(rlmUser)
        XCTAssertEqual(rlmUser.userId, "1")
        XCTAssertEqual(rlmUser.name, "Grigorii")
        XCTAssertEqual(rlmUser.age, 45)
        XCTAssertEqual(rlmUser.email, "650451@tut.by")
        guard rlmUser.categories.count == 2 else {
            XCTFail("Expected categories")
            return
        }
        XCTAssertEqual(rlmUser.categories[0], "category 1")
        XCTAssertEqual(rlmUser.categories[1], "category 2")
        
        let userJson = rlmUser.toDictionary()
        XCTAssertNotNil(userJson)
        let userFromRLMModel = User(dictionary: userJson)
        guard let user = userFromRLMModel else {
            XCTFail("Expected categories")
            return
        }
        XCTAssertNotNil(user)
        XCTAssertEqual(user.userId, "1")
        XCTAssertEqual(user.name, "Grigorii")
        XCTAssertEqual(user.age.intValue, 45)
        XCTAssertEqual(user.email, "650451@tut.by")
        guard user.categories.count == 2 else {
            XCTFail("Expected non-nil user from rlm model")
            return
        }
        XCTAssertEqual(user.categories[0], "category 1")
        XCTAssertEqual(user.categories[1], "category 2")
    }
}
