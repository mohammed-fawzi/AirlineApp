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
    @IBOutlet weak var logoUrlTextField: BindingTextField!
    @IBOutlet weak var websiteTextField: BindingTextField!
    @IBOutlet weak var establishDateTextField: BindingTextField!
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
        
        addAirlineViewModel.logoUrl.subscribe { logoUrl in
            self.logoUrlTextField.text = logoUrl
        }
        
        addAirlineViewModel.website.subscribe { website in
            self.websiteTextField.text = website
        }
        
        addAirlineViewModel.establishDate.subscribe { date in
            self.establishDateTextField.text = date
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
        
        logoUrlTextField.subscribe { url in
            self.addAirlineViewModel.logoUrl.value = url
        }
        
        websiteTextField.subscribe { website in
            self.addAirlineViewModel.website.value = website
        }
        
        establishDateTextField.subscribe { date in
            self.addAirlineViewModel.establishDate.value = date
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
