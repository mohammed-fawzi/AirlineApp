//
//  AirlinesVC.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit

class AirlinesVC: UIViewController {
    
    //MARK:- Outlets & Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    let refreshControl = UIRefreshControl()
    
    var viewModel: AirlinesViewModel!
    var searchController:UISearchController!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        setupTableView()
        setupSearchBarController()
        setupRefreshControl()
        viewModel = AirlinesViewModel()
        bind()
    }

    func setupTableView(){
        tableView.dataSource =  self
        tableView.delegate = self
    }
    
    func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
     
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }
    
}

//MARK:- Datasource
extension AirlinesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAirlines()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airlineCell", for: indexPath) as! AirlineCell
        cell.viewModel = viewModel.airlineCellViewModel(atIndexPath: indexPath)
        return cell
    }
}

//MARK:- Delegate
extension AirlinesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow(atIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- Searchbar
extension AirlinesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        viewModel.searchText = searchText
    }
    
    func setupSearchBarController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Name, ID or Country"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = .systemRed
        navigationItem.searchController = searchController
    }
}

//MARK:- Binding
extension AirlinesVC {
    func bind(){
        bindViewModelProperties()
        bindViewModelActions()
    }
    
    func bindViewModelProperties(){
        viewModel.airlines.subscribe { _ in
            DispatchQueue.main.async {
                if self.refreshControl.isRefreshing {self.refreshControl.endRefreshing()}
                self.tableView.reloadData()
            }
        }
        
        viewModel.searchResults.subscribe { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func bindViewModelActions(){
        viewModel.showDetailViewObserver = {viewModel in
            guard let airlineDetailVC = self.storyboard?.instantiateAirlineDetailsVC() else {return}
            airlineDetailVC.airlineDetailViewModel = viewModel
            self.navigationController?.pushViewController(airlineDetailVC, animated: true)
        }
        
        viewModel.showMessageObserver = { title, message in
            DispatchQueue.main.async {
                self.showAlert(withTitle: title, andErrorMessage: message)
            }
        }
        
        viewModel.showloadingIndicatorObserver = {
            DispatchQueue.main.async {
                self.showLoadingIndicator()
            }
        }
        
        viewModel.dismissloadingIndicatorObserver = {
            DispatchQueue.main.async {
                self.dismissLoadingIndicator()
            }
        }
        
        viewModel.enableAddButtonObserver = {
            DispatchQueue.main.async {
                self.addButton.isEnabled = true
            }
        }
        
        viewModel.disableAddButtonObserver = {
            DispatchQueue.main.async {
                self.addButton.isEnabled = false
            }
        }
    }
}
