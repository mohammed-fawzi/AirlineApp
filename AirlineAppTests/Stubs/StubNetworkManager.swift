//
//  StubNetworkManager.swift
//  AirlineAppTests
//
//  Created by mohamed fawzy on 22September//2021.
//

import Foundation
import XCTest
@testable import AirlineApp

class StubNetworkManager: NetworkManager{
     var success: Bool = false
     var airlines: [Airline] = [Airline]()
     var failuerError: AirlineApiError!
    
     static let sharedStub = StubNetworkManager()
    
    override init() {
        super.init()
    }
    override func getAirlines(completionHandler: @escaping (Result<[Airline], AirlineApiError>) -> Void) {
        if success {
            completionHandler(.success(airlines))
        }else {
            completionHandler(.failure(failuerError))
        }
    }
}
