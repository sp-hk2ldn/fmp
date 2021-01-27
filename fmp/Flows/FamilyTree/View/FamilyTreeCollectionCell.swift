//
//  FamilyTreeCollectionCell.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation
import UIKit

class FamilyTreeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        }
    }
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    
    func configureCell(with person: PersonData) {
        firstnameLabel.text = person.firstname
        surnameLabel.text = person.surname
        if let dob = person.dob {
            dobLabel.text = dob.toDateString()
        } else {
            dobLabel.isHidden = true
        }
        
        if let url = person.image {
            avatarImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
