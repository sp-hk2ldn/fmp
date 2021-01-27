//
//  API.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation

enum APIError: Error {
    case badURL
    case notFound
    case notAuthorized
    case generic
}

class API {
    private static let baseURL = "http://localhost:3001/"
    
    class func getRelationships(id: String, userName: String, completion: @escaping (Result<RelationshipsDataResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)profile/\(id)/\(userName)") else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let _ = error as? APIError {
                    completion(.failure(.generic))
                    return
                }
                fatalError("Data and error should not both be nil")
            }
            let decoder = JSONDecoder()
            let result = Result(catching: {
                try decoder.decode(RelationshipsDataResponse.self, from: data)
            }).mapError { err in
                return APIError.generic
            }
            completion(result)
        }.resume()
    }
    
    class func getPersons(userName: String, completion: @escaping (Result<PersonsDataResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)profiles/\(userName)") else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let _ = error as? APIError {
                    completion(.failure(.generic))
                    return
                }
                fatalError("Data and error should not both be nil")
            }
            let decoder = JSONDecoder()
            let result = Result(catching: {
                try decoder.decode(PersonsDataResponse.self, from: data)
            }).mapError { err in
                return APIError.generic
            }
            completion(result)
        }.resume()
    }
    
    class func mapError(res: URLResponse?) -> APIError {
        return .generic
    }
}
