//
//  DataManager.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation

protocol DataManagerProtocol {
    func clearPersonData()
    func setPersonData(_ persons: [PersonData])
    func clearRelationshipData()
    func setRelationshipData(_ relations: [RelationshipsData])
}

class DataManagerImp: DataManagerProtocol { 
    
    static let shared = DataManagerImp()
    
    private var personList = [PersonData]()
    private var relationshipList = [RelationshipsData]()
    
    func clearPersonData() {
        personList = [PersonData]()
    }
    
    func setPersonData(_ persons: [PersonData]){
        personList = persons
    }
    
    func setRelationshipData(_ relations: [RelationshipsData]) {
        relationshipList = relations
    }
    
    func clearRelationshipData() {
        relationshipList = [RelationshipsData]()
    }
    
    func getPersons() -> [PersonData] {
        return personList
    }
    
    func getRelations() -> [RelationshipsData] {
        return relationshipList
    }
}
