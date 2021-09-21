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


    init() {
        airlines = Observable([Airline]())
        searchResults = Observable([Airline]())
        getAirlines()
    }
    
    private func getAirlines(){
        NetworkManager.shared.getAirlines { result in
            switch result{
            case .success(let airlines):
                self.dismissloadingIndicatorObserver?()
                self.airlines.value = airlines
            case .failure(let error):
                self.showMessageObserver?("OOPs",error.localizedDescription)
            }
        }
    }
    
    func numberOfAirlines()->Int{
        return !searchText.isEmpty ? searchResults.value!.count :airlines.value?.count ?? 0
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
