//
//  AddAirlineViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 20September//2021.
//

import Foundation

class AddAirlineViewModel {
    var id: Observable<String>
    var name: Observable<String>
    var country: Observable<String>
    var slogan: Observable<String>
    var headQuarter: Observable<String>
    var logoUrl: Observable<String>
    var website: Observable<String>
    var establishDate: Observable<String>
    
    var showMessageObserver: ((_ title: String, _ message: String) -> Void)?
    var dismissSelfObserver: (() -> Void)?
    
    init() {
        id = Observable("")
        name = Observable("Test")
        country = Observable("Egypt")
        slogan = Observable("slogan")
        headQuarter = Observable("Cairo")
        logoUrl = Observable("Logo")
        website = Observable("site")
        establishDate = Observable("1994")
        }
        
        func validateInput(name: String, country: String, slogan: String, headQuarter: String) -> AddAirlineFormError? {
           
            if name.isEmpty || country.isEmpty || slogan.isEmpty || headQuarter.isEmpty {
                return .empty
                
            } else if !validate(country: country) {
                return .invalidInput
            }
            
            return nil
        }
    
    func validate(country: String) -> Bool {
            let alphaNumericRegex = "^[a-zA-Z]+$"
            let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
            return alphaNumericTest.evaluate(with: country)
        }
    
    func confirmButtonClicked() {
            if let error = self.validateInput(name: self.name.value ?? "",
                                              country: self.country.value ?? "",
                                              slogan: self.slogan.value ?? "",
                                              headQuarter: self.headQuarter.value ?? "") {
                
                self.showMessageObserver?("Error", error.localizedDescription)
            } else {
                let airline = createModel()
                NetworkManager.shared.addAirline(airline: airline) { error in
                    if let error = error {
                        self.showMessageObserver?("Error",error.localizedDescription)
                    }else{
                        self.showMessageObserver?("Request Completed","\(airline.name) added successfully")
                    }
                }
            }
        }
    
    func cancleButtonClicked(){
        dismissSelfObserver?()
    }
    
    func createModel()->Airline{
        return Airline(id: Double(id.value!), name: name.value ?? "",
                       country: country.value,
                       logo: logoUrl.value,
                       slogan: slogan.value,
                       headQuaters: headQuarter.value,
                       website: website.value,
                       established: establishDate.value)
    }
}
