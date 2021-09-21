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
    case noInternetConnection
    
    var localizedDescription: String {
        switch self {
        case .serverError:
            return "Internal server error please try agian later"
        case .invalidRequest:
            return "Invalid Request"
        case .invalidData:
            return "Corrupted Data"
        case .noInternetConnection:
            return "it seams you do not have access to the internet, we will try fetch your data saved from last online session"
        case .unknownError:
            return "Somthing went wrong please try agian later"
        }

    }
}
