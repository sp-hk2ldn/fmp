//
//  FamilyTreeViewController.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation
import UIKit

class FamilyTreeViewController: UIViewController, Storyboarded {
    var viewModel: FamilyTreeViewModel?
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {

        setupSpinner()
        viewModel?.getTreeData { [weak self] in
            self?.spinner.stopAnimating()
            self?.loadingView.isHidden = true
            self?.collectionView.delegate = self
            self?.collectionView.dataSource = self
        }
    }
    
    func setupSpinner() {
        spinner.startAnimating()
    }
}

extension FamilyTreeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfCollectionViewCellsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyTreeCollectionCell", for: indexPath) as! FamilyTreeCollectionCell
        var section = indexPath.section
        guard let vm = viewModel else { return cell }
        let persons = vm.fetchPersonsForSection(section: &section)
        cell.configureCell(with: persons[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfCollectionViewSections()
    }
    
    
}
