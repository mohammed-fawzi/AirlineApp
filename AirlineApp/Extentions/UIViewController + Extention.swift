//
//  UIViewController + Extention.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 21September//2021.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, andErrorMessage message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
