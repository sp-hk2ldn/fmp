//
//  MainCoordinator.swift
//  fmp
//
//  Created by Stephen Parker on 25/1/2021.
//

import Foundation
import UIKit

final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showError(error: APIError) {
        navigationController.children.first?
            .showGenericAlert(with: error.localizedDescription, message: error.localizedDescription)
    }
    
    func start() {
        navigationController.delegate = self
        let vc = SignInViewController.instantiate(sb: "SignIn")
        let viewModel = SignInViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToPersonList(list: [PersonData]) {
        let vc = PersonListViewController.instantiate(sb: "PersonList")
        let viewModel = PersonListViewModel(personList: list)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToFamilyTree(for person: PersonData) {
        let vc = FamilyTreeViewController.instantiate(sb: "FamilyTree")
        let viewModel = FamilyTreeViewModel(person: person)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
