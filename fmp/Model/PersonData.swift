//
//  PersonsData.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation

struct PersonsDataResponse: Decodable {
    var success: Bool
    var data: [PersonData]?
    var error: String?
}

struct PersonData: Decodable {
    var id: String
    var firstname: String
    var surname: String
    var dob: Date?
    var image: URL?
}

extension PersonData {
    enum CodingKeys: String, CodingKey {
        case id
        case firstname
        case surname
        case dob
        case image
    }
    
    init(from decoder: Decoder) throws {
        let dateFormat: String = "DDMMYYYY"
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let firstname = try container.decode(String.self, forKey: .firstname)
        let surname = try container.decode(String.self, forKey: .surname)
        
        let dobDateString = try container.decodeIfPresent(String.self, forKey: .dob) ?? ""
        let imageURL = try container.decodeIfPresent(String.self, forKey: .image) ?? ""

        
        self.id = id
        self.firstname = firstname
        self.surname = surname
        if !dobDateString.isEmpty {
            self.dob = dobDateString.toDate(dateFormat: dateFormat)
        }
        self.image = URL(string: imageURL)
        
    }
}
