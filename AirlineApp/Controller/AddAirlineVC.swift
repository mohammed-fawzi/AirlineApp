//
//  AddAirlineVC.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit

class AddAirlineVC: UIViewController {
    
    @IBOutlet weak var nameTextField: BindingTextField!
    @IBOutlet weak var countryTextField: BindingTextField!
    @IBOutlet weak var sloganTextField: BindingTextField!
    @IBOutlet weak var headQuarterTextField: BindingTextField!
    
    var addAirlineViewModel: AddAirlineViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addAirlineViewModel = AddAirlineViewModel()
        bind()
    }
    
    func bind(){
        addAirlineViewModel.name.subscribe { name in
            self.nameTextField.text = name
        }
        
        addAirlineViewModel.country.subscribe { country in
            self.countryTextField.text = country
        }
        
        addAirlineViewModel.slogan.subscribe { slogan in
            self.sloganTextField.text = slogan
        }
        
        addAirlineViewModel.headQuarter.subscribe { headQuarter in
            self.nameTextField.text = headQuarter
        }
        
        nameTextField.subscribe { name in
            self.addAirlineViewModel.name.value = name
        }
        
        countryTextField.subscribe { country in
            self.addAirlineViewModel.country.value = country
        }
        
        sloganTextField.subscribe { slogan in
            self.addAirlineViewModel.slogan.value = slogan
        }
        
        headQuarterTextField.subscribe { headQuarter in
            self.addAirlineViewModel.headQuarter.value = headQuarter
        }
        
        self.addAirlineViewModel.showMessageObserver = { [unowned self] title, message in
            self.showAlert(withTitle: title, andErrorMessage: message)
        }
        
        self.addAirlineViewModel.dismissSelfObserver = {
            self.dismiss(animated: true)
        }
        
    }
    
    func showAlert(withTitle title: String, andErrorMessage message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        @IBAction func confirmButtonAction(_ sender: UIButton) {
            self.addAirlineViewModel.confirmButtonClicked()
        }
    
        @IBAction func cancelButtonAction(_ sender: UIButton) {
            self.addAirlineViewModel.cancleButtonClicked()
    }

}
