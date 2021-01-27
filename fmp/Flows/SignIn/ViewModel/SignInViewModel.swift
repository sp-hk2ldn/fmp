//
//  SignInViewModel.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation

protocol SignIn {
    func signIn(with username: String, password: String?)
    func navigateToPersonsList(list: [PersonData])
    func validate(string: String?) -> Bool
    func clearUser()
    func clearPersons()
    func clearRelationships()
}

class SignInViewModel: SignIn {
    func clearUser() {
        UserManagerImpl.shared.clearUser()
    }
    
    func clearPersons() {
        DataManagerImp.shared.clearPersonData()
    }
    
    func clearRelationships() {
        DataManagerImp.shared.clearRelationshipData()
    }
    
 
    weak var coordinator: MainCoordinator?
    
    
    func signIn(with username: String, password: String?) {
        API.getPersons(userName: username) {  [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.coordinator?.showError(error: error)
                case .success(let response):
                    //User is now "logged in"
                    guard let data = response.data else {
                        self?.coordinator?.showError(error: .generic)
                        return
                    }
                    UserManagerImpl.shared.setUser(username: username)
                    self?.navigateToPersonsList(list: data)
                }
            }
        }
    }
    
    func navigateToPersonsList(list: [PersonData]) {
        coordinator?.navigateToPersonList(list: list)
    }
    
    func validate(string: String?) -> Bool {
        //add some validation rules here... for now we'll just assume that something has to exist
        if let string = string {
            if string.isEmpty {
                coordinator?.showError(error: .notAuthorized)
                return false
            }
        }
        return true
    }
}
