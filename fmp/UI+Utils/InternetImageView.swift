//
//  InternetImageView.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation
import UIKit

class InternetImage {
    var imageURL: URL
    var image: UIImage?
    
    init(imageURL: String) {
        self.imageURL = URL(from: imageURL)
    }
}
