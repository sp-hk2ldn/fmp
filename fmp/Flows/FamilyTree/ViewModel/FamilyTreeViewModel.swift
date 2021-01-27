//
//  File.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation

protocol FamilyTreeProtocol {
    var relationships: RelationshipsData? { get }
    var coordinator: MainCoordinator? { get }
    func fetchRelationships(for: PersonData)
}

class FamilyTreeViewModel {
    
    var selectedPerson: PersonData
    var relationships: RelationshipsData?
    var coordinator: MainCoordinator?
    
    init(person: PersonData) {
        self.selectedPerson = person
    }
    
    func getTreeData(completion: @escaping (()-> Void)) {
        fetchRelationships(for: selectedPerson, completion: completion)
    }
    
    func fetchRelationships(for person: PersonData, completion: @escaping (() -> Void)) {
        guard let username = UserManagerImpl.shared.user?.username else {
            coordinator?.showError(error: .generic)
            coordinator?.navigationController.popToRootViewController(animated: true)
            UserManagerImpl.shared.clearUser()
            return
        }
        
        API.getRelationships(id: person.id, userName: username) { [weak self] (response) in
            DispatchQueue.main.async {
                switch response {
                case .failure(let error):
                    self?.coordinator?.showError(error: error)
                case .success(let relationsResponse):
                    self?.relationships = relationsResponse.data.relationships
                    completion()
                }
            }
        }
    }
    
    func numberOfCollectionViewSections() -> Int {
        guard let rel = relationships else { return 0 }
        return rel.returnTypesOfRelationship().count
    }
    
    func numberOfCollectionViewCellsInSection(section: Int) -> Int {
        guard let rel = relationships else { return  .zero }
        switch section {
        case -1:
            return rel.returnCountInGeneration(generation: .Grandparent)
        case 0:
            return rel.returnCountInGeneration(generation: .Parent)
        case 1:
            return rel.returnCountInGeneration(generation: .Current) + 1 //Because the current person is always included
        case 2:
            return rel.returnCountInGeneration(generation: .Child)
        case 3:
            return rel.returnCountInGeneration(generation: .Grandchild)
        default:
            return .zero
        }
    }
    
    func fetchPersonsForSection( section: inout Int) -> [PersonData] {
        guard let relationships = relationships else { return [] }

        switch section {
        case 0:
            if relationships.father == nil && relationships.mother == nil {
                section = 1
            }
            let father = relationships.father?.1
            let mother = relationships.mother?.1
            return DataManagerImp.shared.getPersons().filter { [mother, father].contains($0.id) }
        case 1:
            guard let spouse = relationships.spouse?.1 else { return [selectedPerson] }
            var currentGenerationPersons = DataManagerImp.shared.getPersons().filter { [spouse].contains($0.id) }
            currentGenerationPersons.append(selectedPerson)
            return currentGenerationPersons
        case 2:
            guard let children = relationships.children?.1 else { return [] }
            return DataManagerImp.shared.getPersons().filter { children.contains($0.id) }
        default:
            return []
        }
    }
}
