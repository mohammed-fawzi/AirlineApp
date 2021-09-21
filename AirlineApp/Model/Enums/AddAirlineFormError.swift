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
    case country

    var localizedDescription: String {
        switch self {
        case .empty:
            return "Please, fill all fields"
        case .invalidInput:
            return "Please, enter a valid inputs"
        case .country:
            return "country should contain charachters only"
        }
    }
}
