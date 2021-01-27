//
//  PersonListViewController.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation
import UIKit

class PersonListViewController: UIViewController, Storyboarded {
    var viewModel: PersonListViewModel?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFamilyView: UIView! {
        didSet {
            noFamilyView.isHidden = viewModel?.personList.count != 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        setupTableView()
    }
    
}

extension PersonListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.personList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let person = viewModel?.personList[indexPath.row] else {
            fatalError("Should never happen")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonTableViewCell
        cell.configureCell(with: person)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let person = viewModel?.personList[indexPath.row] else {
            fatalError("Should never happen")
        }
        viewModel?.coordinator?.navigateToFamilyTree(for: person)
    }
}


