//
//  AirlinesViewModelTests.swift
//  AirlineAppTests
//
//  Created by mohamed fawzy on 22September//2021.
//

import XCTest
@testable import AirlineApp

class AirlinesViewModelTests: XCTestCase {
    var sut = AirlinesViewModel()
    let airline1 = Airline(id: 1, name: "test1", country: "Country1", logo: "http://www.test.com", slogan: "testSlogan1", headQuaters: "testHeadQuaters1", website: "http://www.site.com", established: "1994")
    let airline2 = Airline(id: 2, name: "test2", country: "Country2", logo: "http://www.test.com", slogan: "testSlogan2", headQuaters: "testHeadQuaters2", website: "http://www.site.com", established: "1994")
    let airline3 = Airline(id: 3, name: "test3", country: "Country3", logo: "http://www.test.com", slogan: "testSlogan3", headQuaters: "testHeadQuaters3", website: "http://www.site.com", established: "1994")
    
    override func setUpWithError() throws {
        sut = AirlinesViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK:- Init
    func testInit_ValidView_InstantiatesObject() {
    let viewModel = AirlinesViewModel()
    XCTAssertNotNil(viewModel)
    }
    
    func testInit_InitializeAirlineObject() {
        sut = AirlinesViewModel()
        XCTAssertNotNil(sut.airlines)
    }
    
    func testInit_InitializeSearchResultObject() {
        sut = AirlinesViewModel()
        XCTAssertNotNil(sut.searchResults)
    }
    
    //MARK:- NumberOfAirlines
    func testNumberOfAirlines_airlinesNil_returnsZero(){
        sut.airlines.value = nil
        sut.searchResults.value = [airline1,airline2]
        let count = sut.numberOfAirlines()
        XCTAssertEqual(count, 0)
    }
    
    func testNumberOfAirlines_searchResultNil_returnsZero(){
        sut.airlines.value = [airline1,airline2]
        sut.searchResults.value = nil
        let count = sut.numberOfAirlines()
        XCTAssertEqual(count, 0)
    }
    
    func testNumberOfAirlines_searchTextEmpty_returnsAirlinesCount(){
        sut.searchText = ""
        sut.airlines.value = [airline1,airline2,airline3]
        sut.searchResults.value = [airline1,airline2]
        let count = sut.numberOfAirlines()
        XCTAssertEqual(count, 3)
    }
    
    func testNumberOfAirlines_searchNotEmpty_returnsSearchResultCount(){
        sut.searchText = "xtzera"
        sut.airlines.value = [airline1,airline2,airline3]
        sut.searchResults.value = [airline1,airline2]
        let count = sut.numberOfAirlines()
        XCTAssertEqual(count, 2)
    }
    
    //MARK:-  airlineCellViewModel
    func testAirlineCellViewModel_airlineValueNil_returnsNil(){
        sut.airlines.value = nil
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineCellVM = sut.airlineCellViewModel(atIndexPath: indexPath)
        XCTAssertNil(airlineCellVM)
    }
    
    func testAirlineCellViewModel_indexPathRowLessThanZero_returnsNil(){
        sut.airlines.value = [airline1,airline2]
        let indexPath = IndexPath(row: -1, section: 0)
        let airlineCellVM = sut.airlineCellViewModel(atIndexPath: indexPath)
        XCTAssertNil(airlineCellVM)
    }
    
    func testAirlineCellViewModel_indexPathRowGreaterThanAirlinesCount_returnsNil(){
        sut.airlines.value = [airline1,airline2]
        let indexPath = IndexPath(row: 3, section: 0)
        let airlineCellVM = sut.airlineCellViewModel(atIndexPath: indexPath)
        XCTAssertNil(airlineCellVM)
    }
    
    func testAirlineCellViewModel_searchTextEmpty_returnsAirlineViewModelFromAirlines(){
        sut.searchText = ""
        sut.airlines.value = [airline2,airline1,airline3]
        sut.searchResults.value = [airline1,airline2]
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineCellVM = sut.airlineCellViewModel(atIndexPath: indexPath)
        XCTAssertEqual(airlineCellVM!.name.value!,airline2.name )
    }
    
    func testAirlineCellViewModel_searchTextNotEmpty_returnsAirlineViewModelFromAirlines(){
        sut.searchText = "xtzera"
        sut.airlines.value = [airline2,airline1,airline3]
        sut.searchResults.value = [airline1,airline2]
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineCellVM = sut.airlineCellViewModel(atIndexPath: indexPath)
        XCTAssertEqual(airlineCellVM!.name.value!,airline1.name )
    }
    
    //MARK:-  airlineDetailsViewModel
    func testAirlineDetailsViewModel_airlineValueNil_returnsNil(){
        sut.airlines.value = nil
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineCellVM = sut.airlineDetailsViewModel(atIndexPath: indexPath)
        XCTAssertNil(airlineCellVM)
    }
    
    func testAirlineDetailsViewModel_indexPathRowLessThanZero_returnsNil(){
        sut.airlines.value = [airline1,airline2]
        let indexPath = IndexPath(row: -1, section: 0)
        let airlineCellVM = sut.airlineDetailsViewModel(atIndexPath: indexPath)
        XCTAssertNil(airlineCellVM)
    }
    
    func testAirlineDetailsViewModel_indexPathRowGreaterThanAirlinesCount_returnsNil(){
        sut.airlines.value = [airline1,airline2]
        let indexPath = IndexPath(row: 3, section: 0)
        let airlineCellVM = sut.airlineDetailsViewModel(atIndexPath: indexPath)
        XCTAssertNil(airlineCellVM)
    }
    
    func testAirlineDetailsViewModel_searchTextEmpty_returnsAirlineViewModelFromAirlines(){
        sut.searchText = ""
        sut.airlines.value = [airline2,airline1,airline3]
        sut.searchResults.value = [airline1,airline2]
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineCellVM = sut.airlineDetailsViewModel(atIndexPath: indexPath)
        XCTAssertEqual(airlineCellVM!.airline.value!.id,airline2.id )
    }
    
    func testAirlineDetailsViewModel_searchTextNotEmpty_returnsAirlineViewModelFromAirlines(){
        sut.searchText = "xtzera"
        sut.airlines.value = [airline2,airline1,airline3]
        sut.searchResults.value = [airline1,airline2]
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineCellVM = sut.airlineDetailsViewModel(atIndexPath: indexPath)
        XCTAssertEqual(airlineCellVM!.airline.value!.id,airline1.id )
    }
    
    //MARK:- SelectedRow
    func testSelectedRow_Calls_ShowDetailsViewObserver_OnAirlinesVC() {
        let expectation = self.expectation(description: "expected ShowDetailsViewObserver to be called with expected DetailsVCViewModel")
        let mockViewController = MockAirlinesVC()
        sut.airlines.value = [airline1,airline2,airline3]
        let indexPath = IndexPath(row: 0, section: 0)
        let airlineDetailsViewModel = AirlineDetailsViewModel(model: airline1)
        mockViewController.expectationForShowDetailsViewObserver = (expectation,airlineDetailsViewModel)
        mockViewController.viewModel = sut
        mockViewController.viewDidLoad()
        sut.selectedRow(atIndexPath: indexPath)
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    

    //MARK:- GetAirlines
    // Success
    func testGetAirlines_successNetworkCall_callDismissLoadingIndicator(){
        let expectation = self.expectation(description: "expected dismissLoadingIndicator on airlinesVC")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = true
        stubNetworkManager.failuerError = .none
        let mockAirlinesVC = MockAirlinesVC()
        mockAirlinesVC.viewModel = sut
        mockAirlinesVC.expectationForDsmissloadingIndicatorObserver = expectation
        mockAirlinesVC.bind()
        sut.networkManager = stubNetworkManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGetAirlines_successNetworkCall_updateAirlines(){
        let stubNetworkManager = StubNetworkManager.sharedStub
        let networkResultAirlines = [airline1,airline3]
        stubNetworkManager.success = true
        stubNetworkManager.failuerError = .none
        stubNetworkManager.airlines = networkResultAirlines
        sut.networkManager = stubNetworkManager
        sut.getAirlines()
        let updatedAirlines = sut.airlines.value!
        XCTAssertEqual(updatedAirlines, networkResultAirlines)
    }
    
    func testGetAirlines_successNetworkCall_callEnableAddButtonObserver(){
        let expectation = self.expectation(description: "expected enableAddButtonObserver on airlinesVC")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = true
        stubNetworkManager.failuerError = .none
        let mockAirlinesVC = MockAirlinesVC()
        mockAirlinesVC.viewModel = sut
        mockAirlinesVC.expectationForEnableAddButtonObserver = expectation
        mockAirlinesVC.bind()
        sut.networkManager = stubNetworkManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGetAirlines_successNetworkCall_callAddAirlinesOnPerssistence(){
        let expectation = self.expectation(description: "expected call addAirlines On Perssistence manager")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = true
        stubNetworkManager.failuerError = .none
        let stubPersistanceManager = StubPersistenceManager.sharedStub
        stubPersistanceManager.expectationForAddAirlines = expectation
        sut.networkManager = stubNetworkManager
        sut.persistenceManager = stubPersistanceManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // Failuer
    func testGetAirlines_noInternetConnection_callDismissLoadingIndicator(){
        let expectation = self.expectation(description: "expected with no internet connection callDismissLoadingIndicator on airlinesVC")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = false
        stubNetworkManager.failuerError = .noInternetConnection
        let mockAirlinesVC = MockAirlinesVC()
        mockAirlinesVC.viewModel = sut
        mockAirlinesVC.expectationForDsmissloadingIndicatorObserver = expectation
        mockAirlinesVC.bind()
        sut.networkManager = stubNetworkManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetAirlines_noInternetAccess_callGetAllAirlinesOnPerssistence(){
        let expectation = self.expectation(description: "expected call getAllAirlines On Perssistence manager")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = false
        stubNetworkManager.failuerError = .noInternetConnection
        let stubPersistanceManager = StubPersistenceManager.sharedStub
        stubPersistanceManager.expectationForGetAllAirlines = expectation
        sut.networkManager = stubNetworkManager
        sut.persistenceManager = stubPersistanceManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetAirlines_noInternetConnection_updateAirlinesWithStoredData(){
        let stubPersistanceManager = StubPersistenceManager.sharedStub
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = false
        stubNetworkManager.failuerError = .noInternetConnection
        stubPersistanceManager.initializeFakeAirlines()
        sut.persistenceManager = stubPersistanceManager
        sut.networkManager = stubNetworkManager
        let expectedAirlines = [airline1,airline2,airline3]
        sut.getAirlines()
        let updatedAirlines = sut.airlines.value!
        XCTAssertEqual(updatedAirlines, expectedAirlines)
    }
    
    func testGetAirlines_noInternetConnection_callDisableAddButtonObserver(){
        let expectation = self.expectation(description: "expected disableAddButtonObserver on airlinesVC")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = false
        stubNetworkManager.failuerError = .noInternetConnection
        let mockAirlinesVC = MockAirlinesVC()
        mockAirlinesVC.viewModel = sut
        mockAirlinesVC.expectationForDisableAddButtonObserver = expectation
        mockAirlinesVC.bind()
        sut.networkManager = stubNetworkManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetAirlines_errorNotNoInternetConnection_callshowMessageObserver(){
        let expectation = self.expectation(description: "expected call showMessageObserver on airlinesVC")
        let stubNetworkManager = StubNetworkManager.sharedStub
        stubNetworkManager.success = false
        stubNetworkManager.failuerError = .unknownError
        let mockAirlinesVC = MockAirlinesVC()
        mockAirlinesVC.viewModel = sut
        mockAirlinesVC.expectationForShowMessageObserver = (expectation,"OOPs",AirlineApiError.unknownError.localizedDescription)
        mockAirlinesVC.bind()
        sut.networkManager = stubNetworkManager
        sut.getAirlines()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

}
