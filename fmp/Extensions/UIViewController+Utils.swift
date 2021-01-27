//
//  UIViewController+Utils.swift
//  fmp
//
//  Created by Stephen Parker on 27/1/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with apiError: APIError, completion: (() -> Void)? = nil) {
        var title = ""
        switch apiError {
        case .notAuthorized:
            title = "Error: Resource not authorized"
        case .notFound:
            title = "Error: Resource not found"
        default:
            title = "Error: Please try again later"
        }
        showGenericAlert(with: title, message: apiError.localizedDescription)
    }
    
    func showGenericAlert(with title: String, message: String, handler: (() -> Void)? = nil) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func showAlertWith(title: String? = nil, message: String? = nil) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertView, animated: true, completion: nil)
    }
}
