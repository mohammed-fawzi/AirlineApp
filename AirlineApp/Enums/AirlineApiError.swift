//
//  AirlineApiError.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

enum AirlineApiError: Error {
    case serverError
    case invalidRequest
    case invalidData
    case unknownError
    
    var localizedDescription: String {
        
        switch self {
        case .serverError:
            return "Internal server error please try agian later"
        case .invalidRequest:
            return "Invalid Request"
        case .invalidData:
            return "Corrupted Data"
        case .unknownError:
            return "Somthing went wrong please try agian later"
        }

    }
}
