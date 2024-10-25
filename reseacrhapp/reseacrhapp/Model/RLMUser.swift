//
//  RLMUser.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

import RealmSwift

final class RLMUser: Object {
    @objc dynamic var userId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var email: String = ""
    dynamic var categories = List<String>()
    
    @objc dynamic var desc: String {
        return """
            userId: \(String(describing: userId))
            name: \(String(describing: name))
            age: \(String(describing: age))
            email: \(String(describing: email))
            categories: \(String(describing: categories))
        """
    }
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    class func from(model: User) -> RLMUser {
        let rlmUser = RLMUser()
        rlmUser.userId = model.userId
        rlmUser.name = model.name
        rlmUser.age = model.age.intValue
        rlmUser.email = model.email
        let list = List<String>()
        model.categories?.forEach { list.append($0) }
        rlmUser.categories = list
        
        return rlmUser
    }
    
    func toDictionary() -> [AnyHashable: Any] {
        var categoriesForJson = [String]()
        categories.forEach {
            categoriesForJson.append($0)
        }
        return [
            "id" : userId,
            "name": name,
            "age": "\(age)",
            "email": email,
            "categories": categoriesForJson
        ]
    }
}
