//
//  ViewController.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 21September//2021.
//

import UIKit

class BindingSearchTextField: UISearchTextField {

    var textChanged: (String) -> () = { _ in }
    
    func subscribe(callback: @escaping (String) -> ()) {
        
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField :UITextField) {
        
        self.textChanged(textField.text!)
    }
}
