//
//  DatabaseService.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

// Protocol for working with users: save and fetch users from a storage
protocol DatabaseService {
    // Save User to storage
    func save(model: User)

    // get Users from storage
    func userList() -> [User]
    
    //get all categories
    func allCategories() -> [String]
}
