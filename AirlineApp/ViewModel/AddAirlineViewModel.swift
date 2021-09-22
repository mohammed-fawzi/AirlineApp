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
    var showloadingIndicatorObserver: (() -> Void)?
    var dismissloadingIndicatorObserver: (() -> Void)?
    
    init() {
        id = Observable("")
        name = Observable("")
        country = Observable("")
        slogan = Observable("")
        headQuarter = Observable("")
        logoUrl = Observable("")
        website = Observable("")
        establishDate = Observable("")
        }
        
    func confirmButtonClicked() {
        if let error = validateInput(id: id.value ?? "",
                                          name: name.value ?? "",
                                          country: country.value ?? "",
                                          slogan: slogan.value ?? "",
                                          headQuarter: headQuarter.value ?? "") {
                
                showMessageObserver?("Error", error.localizedDescription)
            } else {
                showloadingIndicatorObserver?()
                let airline = createModel()
                NetworkManager.shared.addAirline(airline: airline) { error in
                    self.dismissloadingIndicatorObserver?()
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
        return Airline(id: Double(id.value!),
                       name: name.value ?? "",
                       country: country.value,
                       logo: logoUrl.value,
                       slogan: slogan.value,
                       headQuaters: headQuarter.value,
                       website: website.value,
                       established: establishDate.value)
    }
}

//MARK:- Validate
extension AddAirlineViewModel {
    func validateInput(id:String, name: String, country: String, slogan: String, headQuarter: String) -> AddAirlineFormError? {
           print(id)
        if id.isEmpty || name.isEmpty || country.isEmpty || slogan.isEmpty || headQuarter.isEmpty {
                return .empty
            }
        else if !validate(country: country) {
                return .country
            }
            
            return nil
        }
    
    func validate(country: String) -> Bool {
            let alphaNumericRegex = "^[a-zA-Z]+$"
            let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
            return alphaNumericTest.evaluate(with: country)
        }
}
