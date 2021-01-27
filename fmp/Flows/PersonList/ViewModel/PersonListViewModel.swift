//
//  PersonListViewModel.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation

protocol PersonListProtocol {
    var coordinator: MainCoordinator? { get }
    var personList: [PersonData] { get }
}

class PersonListViewModel: PersonListProtocol {
    var coordinator: MainCoordinator?
    var personList: [PersonData]
    
    init(personList: [PersonData]) {
        self.personList = personList
        DataManagerImp.shared.setPersonData(personList)
    }
}
