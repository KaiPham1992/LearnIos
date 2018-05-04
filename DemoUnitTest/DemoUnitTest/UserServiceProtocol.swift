//
//  UserServiceProtocol.swift
//  DemoUnitTest
//
//  Created by Kai Pham on 4/23/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//

import UIKit

protocol UserServiceProtocol {
    func getUsers() -> [User]
}


class UserService: NSObject, UserServiceProtocol {
    
    func getUsers() -> [User] {
        var user1 = User()
        user1.userName = "user1"
        user1.email = "user1@framgia.com"
        user1.fullName = "User 1"
        
        var user2 = User()
        user2.userName = "user2"
        user2.email = "user2@framgia.com"
        user2.fullName = "User 2"
        
        return [user1, user2]
    }
}
