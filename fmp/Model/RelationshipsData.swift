//
//  RelationshipsData.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation

struct RelationshipsDataResponse: Decodable {
    var success: Bool
    var data: RelationshipsDictionary
    var error: String?
}

struct RelationshipsDictionary: Decodable {
    var id: String
    var firstname: String
    var surname: String
    var dob: String?
    var image: String?
    var relationships: RelationshipsData
}



struct RelationshipsData: Decodable {
    
    
    var spouse: (RelationshipType, String)?
    var mother: (RelationshipType, String)?
    var father: (RelationshipType, String)?
    var children: (RelationshipType, [String])?
    
    func returnTypesOfRelationship() -> [Any] {
        return [spouse as Any, mother as Any,
            father as Any, children as Any].filter {
            $0 as? (RelationshipType, String) != nil || $0 as? (RelationshipType, [String]) != nil
        }
    }
    
    func returnCountInGeneration(generation: Generation) -> Int {
        var count = 0
        switch generation {
        case.Child:
            if let children = children {
                count = children.1.count
            }
        case .Current:
            if let _ = spouse {
                count = 1
            }
        case .Parent:
            
            count = [mother?.1, father?.1].compactMap { $0 }.count
        default:
            count = 0
        }
        return count
    }
}

extension RelationshipsData {
    enum CodingKeys: String, CodingKey {
        case spouse, mother, father, children
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let spouse = try container.decodeIfPresent(String.self, forKey: .spouse)
        let father = try container.decodeIfPresent(String.self, forKey: .father)
        let mother = try container.decodeIfPresent(String.self, forKey: .mother)
        let children = try container.decodeIfPresent([String].self, forKey: .children)
        
        if let spouse = spouse {
            self.spouse = (.Spouse, spouse)
        }
        if let father = father {
            self.father = (.Father, father)
        }
        if let mother = mother {
            self.mother = (.Mother, mother)
        }
        if let children = children {
            self.children = (.Child, children)
        }
    }
}
