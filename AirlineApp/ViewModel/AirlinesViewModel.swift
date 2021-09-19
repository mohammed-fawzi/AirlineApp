//
//  AirlinesViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

class AirlinesViewModel {
    

    var messageObserver: ((_ title: String, _ message: String) -> Void)?
    
    var airlines: Observable<[Airline]>!
    
    init() {
        airlines = Observable([Airline]())
        getAirlines()
    }
    
    private func getAirlines(){
        NetworkManager.shared.getAirlines { result in
            switch result{
            case .success(let airlines):
                self.airlines.value = airlines
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func numberOfAirlines()->Int{
        return airlines.value?.count ?? 0
    }
    
    func airlineCellViewModel(atIndexPath indexPath:IndexPath) -> AirlineCellViewModel? {
        guard let airlines = airlines.value else {return nil}
        if ((indexPath.row < 0) || (indexPath.row >= numberOfAirlines())) {return nil}
        let airline = airlines[indexPath.row]
        return AirlineCellViewModel(model: airline)
    }
    
  
    
}
