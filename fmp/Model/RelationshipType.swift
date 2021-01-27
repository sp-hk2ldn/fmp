//
//  RelationshipType.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation

enum RelationshipType {
    case Grandfather
    case Grandmother
    case Spouse
    case Mother
    case Father
    case Child
    case Grandchild
    case Sister
    case Brother
}

extension RelationshipType {
    var generation: Generation {
        switch self {
        case .Child:
            return .Child
        case .Father, .Mother:
            return .Parent
        case .Spouse, .Sister, .Brother:
            return .Current
        case .Grandfather, .Grandmother:
            return .Grandparent
        case .Grandchild:
            return .Grandchild
        }
    }
}

enum Generation: Int {
    case Grandparent = -2
    case Parent = -1
    case Current = 0
    case Child = 1
    case Grandchild = 2
}
