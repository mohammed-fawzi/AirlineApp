//
//  AirlinesVCProtocol.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 22September//2021.
//

import Foundation

protocol AirlinesVCProtocol {
    var viewModel: AirlinesViewModel! { get set }
    func setupTableView()
    func setupSearchBarController()
    func setupRefreshControl()
    func bind()
    func refresh(_ sender: AnyObject)
    func bindViewModelProperties()
    func bindViewModelActions()
}
