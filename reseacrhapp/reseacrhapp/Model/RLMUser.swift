//
//  RLMUser.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

import RealmSwift

// Realm internal model class. We should not use this model class out of database service
final class RLMUser: Object {
    @objc @Persisted(primaryKey: true) var userId: String = ""
    @objc @Persisted var name: String = ""
    @objc @Persisted var age: Int = 0
    @objc @Persisted var email: String = ""
    @Persisted var categories = List<String>()

    @objc dynamic var desc: String {
        return """
            userId: \(String(describing: userId))
            name: \(String(describing: name))
            age: \(String(describing: age))
            email: \(String(describing: email))
            categories: \(String(describing: categories))
        """
    }

    @objc class func from(model: User) -> RLMUser {
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
        for category in categories {
            categoriesForJson.append(category)
        }
        return [
            "id": userId,
            "name": name,
            "age": "\(age)",
            "email": email,
            "categories": categoriesForJson,
        ]
    }
}
