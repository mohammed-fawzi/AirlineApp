//
//  AddAirlineViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 20September//2021.
//

import Foundation

class AddAirlineViewModel {
    var name: Observable<String>!
    var country: Observable<String>!
    var slogan: Observable<String>!
    var headQuarter: Observable<String>!
    var logoUrl: Observable<String>!
    var website: Observable<String>!
    var establishDate: Observable<String>!
    
    var showMessageObserver: ((_ title: String, _ message: String) -> Void)?
    var dismissSelfObserver: (() -> Void)?
    private var airline: Airline?
    
    init(airline: Airline? = nil) {
            self.airline = airline
            
            if let airline = airline {
                self.setAirlineModel(airline)
            }else{
                self.airline = Airline(name: "", country: "", logo: "", slogan: "", headQuaters: "",website: "", established: "")
                self.setAirlineModel(self.airline!)
            }
        }
        
        func setAirlineModel(_ airline: Airline) {
            name = Observable(airline.name)
            country = Observable(airline.country ?? "")
            slogan = Observable(airline.slogan ?? "")
            headQuarter = Observable(airline.headQuaters ?? "")
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
                
            }
        }
    
    func cancleButtonClicked(){
        dismissSelfObserver?()
    }
}
