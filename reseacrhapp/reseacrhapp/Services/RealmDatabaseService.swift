//
//  RealmDatabaseService.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//
import Foundation
import RealmSwift

final class RealmDatabaseService: DatabaseService {
    // Save User to database
    func save(model: User) {
        let realm = try! Realm()
        let rlmUser = RLMUser.from(model: model)
        try! realm.write {
            realm.add(rlmUser)
        }
        
    }
    
    // Get Users from database
    func userList() -> [User] {
        let realm = try! Realm()
        let rlmUsers = realm.objects(RLMUser.self)
        let result: [User] = rlmUsers.map{ User(dictionary: $0.toDictionary()) }
        return result
    }
}
