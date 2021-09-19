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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource =  self
        tableView.delegate = self
        
        viewModel = AirlinesViewModel()
        bind()
    }

    func bind(){
        viewModel.airlines.subscribe { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

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

extension AirlinesVC: UITableViewDelegate{
    
}