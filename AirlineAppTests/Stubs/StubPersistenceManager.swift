//
//  StubPersistenceManager.swift
//  AirlineAppTests
//
//  Created by mohamed fawzy on 22September//2021.
//

import Foundation
import XCTest
import CoreData
@testable import AirlineApp

class StubPersistenceManager: PersistenceManager {
    var expectationForAddAirlines: XCTestExpectation?
    var expectationForGetAllAirlines: XCTestExpectation?
    var resultCDAirlines = [CDAirline]()
    
    static let sharedStub = StubPersistenceManager()
    override init() {
        super.init()
        self.initializeFakeAirlines()
    }
    
    override func addAirlines(airlines: [Airline]) {
        expectationForAddAirlines?.fulfill()
    }
    
    override func getAllAirlines() -> [CDAirline] {
        expectationForGetAllAirlines?.fulfill()
        return resultCDAirlines
    }
    
    func initializeFakeAirlines(){
        let cdAirline1 = CDAirline(context: container.viewContext)
        cdAirline1.id = 1
        cdAirline1.name = "test1"
        cdAirline1.country = "Country1"
        cdAirline1.established = "1994"
        cdAirline1.logo = "http://www.test.com"
        cdAirline1.headQuaters = "testHeadQuaters1"
        cdAirline1.slogan = "testSlogan1"
        cdAirline1.website = "http://www.site.com"
        
        let cdAirline2 = CDAirline(context: container.viewContext)
        cdAirline2.id = 2
        cdAirline2.name = "test2"
        cdAirline2.country = "Country2"
        cdAirline2.established = "1994"
        cdAirline2.logo = "http://www.test.com"
        cdAirline2.headQuaters = "testHeadQuaters2"
        cdAirline2.slogan = "testSlogan2"
        cdAirline2.website = "http://www.site.com"
        
        let cdAirline3 = CDAirline(context: container.viewContext)
        cdAirline3.id = 3
        cdAirline3.name = "test3"
        cdAirline3.country = "Country3"
        cdAirline3.established = "1994"
        cdAirline3.logo = "http://www.test.com"
        cdAirline3.headQuaters = "testHeadQuaters3"
        cdAirline3.slogan = "testSlogan3"
        cdAirline3.website = "http://www.site.com"
        
        resultCDAirlines = [cdAirline1,cdAirline2,cdAirline3]
    }
}
