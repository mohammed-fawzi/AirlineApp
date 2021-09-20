//
//  AirlineDetailsVC.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit

class AirlineDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var headquarterLabel: UILabel!
    
    var airlineDetailViewModel: AirlineDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind(){
        airlineDetailViewModel.airline.subscribe { airline in
            self.nameLabel.text = airline?.name ?? ""
            self.countryLabel.text = airline?.country ?? ""
            self.sloganLabel.text = airline?.slogan ?? ""
            self.headquarterLabel.text = airline?.headQuaters ?? ""
        }
    }
    

}
