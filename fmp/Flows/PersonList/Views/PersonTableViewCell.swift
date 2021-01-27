//
//  PersonTableViewCell.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation
import UIKit
import SDWebImage

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(with person: PersonData) {
        dobLabel.text = person.dob?.toDateString() ?? ""
        nameLabel.text = "\(person.firstname) \(person.surname)"
        if let url = person.image {
            avatarView.sd_setImage(with: url, completed: nil)
        }
    }
}
