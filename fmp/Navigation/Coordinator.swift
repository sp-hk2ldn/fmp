//
//  Coordinator.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
