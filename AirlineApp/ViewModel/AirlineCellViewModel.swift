//
//  AirlineCellViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

class AirlineCellViewModel{
    var name: Observable<String>!
    
    init(model: Airline) {
        name = Observable(model.name)
    }
}
