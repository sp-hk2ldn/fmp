//
//  Storyboarded.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(sb: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(sb: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: sb, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
