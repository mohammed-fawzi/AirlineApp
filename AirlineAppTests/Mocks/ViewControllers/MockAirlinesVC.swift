//
//  MockAirlinesVC.swift
//  AirlineAppTests
//
//  Created by mohamed fawzy on 22September//2021.
//

import UIKit
import XCTest
@testable import AirlineApp

class MockAirlinesVC: UIViewController, AirlinesVCProtocol {
    var viewModel: AirlinesViewModel!
    
    var expectationForShowDetailsViewObserver: (XCTestExpectation,AirlineDetailsViewModel)?
    var expectationForShowMessageObserver: (XCTestExpectation, String, String)?
    var expectationForshowloadingIndicatorObserver: XCTestExpectation?
    var expectationForDsmissloadingIndicatorObserver: XCTestExpectation?
    var expectationForDisableAddButtonObserver: XCTestExpectation?
    var expectationForEnableAddButtonObserver: XCTestExpectation?
    
    func setupSearchBarController() {
        
    }
    
    override func viewDidLoad() {
        bind()
    }
    
    func bind() {
        bindViewModelActions()
        bindViewModelProperties()
    }
    
    func refresh(_ sender: AnyObject) {
        
    }
    
    func bindViewModelProperties() {
        
    }
    
    func setupTableView() {
        
    }
    
    func setupRefreshControl() {
        
    }
    

    func bindViewModelActions() {
        viewModel.showDetailViewObserver = { viewModel in
            if let (expectation, expectedValue) = self.expectationForShowDetailsViewObserver {
                if expectedValue.airline!.value!.id == viewModel!.airline.value!.id {
                    expectation.fulfill()
                }
            }
        }
        
        viewModel.showMessageObserver = { [unowned self] title, message in
            if let (expectation, expectedTitle, expectedMessage) = self.expectationForShowMessageObserver {
                if expectedTitle == title && expectedMessage == message {
                    expectation.fulfill()
                }
            }
        }
        
        viewModel.showloadingIndicatorObserver = { [unowned self] in
            expectationForshowloadingIndicatorObserver?.fulfill()
        }
        
        viewModel.dismissloadingIndicatorObserver = { [unowned self] in
            expectationForDsmissloadingIndicatorObserver?.fulfill()
        }
        
        viewModel.enableAddButtonObserver = { [unowned self] in
            expectationForEnableAddButtonObserver?.fulfill()
        }
        
        viewModel.disableAddButtonObserver = { [unowned self] in
            expectationForDisableAddButtonObserver?.fulfill()
        }
    }
    
    
    


}
