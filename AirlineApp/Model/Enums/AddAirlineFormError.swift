//
//  AddAirlineFormError.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 20September//2021.
//

import Foundation

enum AddAirlineFormError: Error {
    case empty
    case invalidInput

    
    var localizedDescription: String {
        
        switch self {
        case .empty:
            return "Please, fill all fields"
        case .invalidInput:
            return "Please, enter a valid inputs"
        }

    }
}
