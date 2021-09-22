//
//  AirlinesViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

class AirlinesViewModel {
    
    var airlines: Observable<[Airline]>!
    var searchResults: Observable<[Airline]>!
    var searchText: String = "" {
        willSet {
            updateSearchResults(newValue)
        }
    }
    
    var showMessageObserver: ((_ title: String, _ message: String) -> Void)?
    var showDetailViewObserver: ((_ viewModel: AirlineDetailsViewModel?) -> Void)?
    var showloadingIndicatorObserver: (() -> Void)?
    var dismissloadingIndicatorObserver: (() -> Void)?
    var disableAddButtonObserver: (() -> Void)?
    var enableAddButtonObserver: (() -> Void)?
    
    var networkManager = NetworkManager.shared
    var persistenceManager = PersistenceManager.shared
    init() {
        airlines = Observable([Airline]())
        searchResults = Observable([Airline]())
        getAirlines()
    }
    
    func getAirlines(){
        networkManager.getAirlines { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let airlines):
                self.dismissloadingIndicatorObserver?()
                self.airlines.value = airlines
                self.persistenceManager.addAirlines(airlines: airlines)
                self.enableAddButtonObserver?()
            case .failure(let error):
                if error == .noInternetConnection {
                    self.dismissloadingIndicatorObserver?()
                    let cdAirlines = self.persistenceManager.getAllAirlines()
                    self.airlines.value = cdAirlines.map {Airline(cdAirline: $0)}
                    self.disableAddButtonObserver?()
                }
                self.showMessageObserver?("OOPs",error.localizedDescription)
            }
        }
    }
    
    func refresh(){
        self.showloadingIndicatorObserver?()
        getAirlines()
    }
    
    func numberOfAirlines()->Int{
        guard let searchResults = searchResults.value,
              let airlines = airlines.value else {return 0}
        return !searchText.isEmpty ? searchResults.count :airlines.count
    }
    
    func selectedRow(atIndexPath indexPath: IndexPath){
        let airlineDetailsViewModel = airlineDetailsViewModel(atIndexPath: indexPath)
        showDetailViewObserver?(airlineDetailsViewModel)
    }
    
    //MARK:- ViewModels
    func airlineCellViewModel(atIndexPath indexPath:IndexPath) -> AirlineCellViewModel? {
        guard let airlines = airlines.value else {return nil}
        if ((indexPath.row < 0) || (indexPath.row >= numberOfAirlines())) {return nil}
        let airline = !searchText.isEmpty ? searchResults.value![indexPath.row] :airlines[indexPath.row]
        return AirlineCellViewModel(model: airline)
    }
    
    func airlineDetailsViewModel(atIndexPath indexPath:IndexPath) -> AirlineDetailsViewModel? {
        guard let airlines = airlines.value else {return nil}
        if ((indexPath.row < 0) || (indexPath.row >= numberOfAirlines())) {return nil}
        let airline = !searchText.isEmpty ? searchResults.value![indexPath.row] : airlines[indexPath.row]
        return AirlineDetailsViewModel(model: airline)
    }
    
    //MARK:- Search
    private func updateSearchResults(_ searchText: String?) {
        guard let airlines = airlines.value,
              let searchText = searchText,
              !searchText.isEmpty else {
            searchResults.value?.removeAll()
            return
        }
        searchResults.value = airlines.filter{ (airline:Airline) -> Bool in
            return checkIf(airline: airline, contains: searchText)
        }
    }
    
    private func checkIf(airline: Airline, contains searchText: String)-> Bool {
        let textSearchCompareOptions: NSString.CompareOptions = [ .caseInsensitive , .literal]
        let nameMatch = airline.name.range(of: searchText, options: textSearchCompareOptions)
        let countryMatch = airline.country?.range(of: searchText, options: textSearchCompareOptions)
        //some api airlines do not have id
        let idMatch = (airline.id != nil) ? (airline.id == Double(searchText)) : false
        return nameMatch != nil || countryMatch != nil || idMatch
    }
}
