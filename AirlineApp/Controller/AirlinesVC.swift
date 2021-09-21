//
//  AirlinesVC.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit

class AirlinesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: AirlinesViewModel!
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBarController()
        viewModel = AirlinesViewModel()
        bind()
    }

    func bind(){
        viewModel.airlines.subscribe { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.searchResults.subscribe { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.showDetailViewObserver = {viewModel in
            guard let airlineDetailVC = self.storyboard?.instantiateAirlineDetailsVC() else {return}
            airlineDetailVC.airlineDetailViewModel = viewModel
            self.navigationController?.pushViewController(airlineDetailVC, animated: true)
        }
    }

    func setupTableView(){
        tableView.dataSource =  self
        tableView.delegate = self
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
