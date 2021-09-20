//
//  AirlineDetailsViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 20September//2021.
//

import Foundation

class AirlineDetailsViewModel {
    var airline: Observable<Airline>!
    
    init(model: Airline) {
        airline = Observable(model)
    }
}
