//
//  UserManager.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation

protocol UserManagerProtocol {
    func clearUser()
    func setUser()
}

class UserManagerImpl {
    static let shared = UserManagerImpl()
    
    var user: User?
    
    func clearUser() {
        user = nil
    }
    
    func setUser(username: String) {
        let user = User(username: username)
        self.user = user
    }
}
