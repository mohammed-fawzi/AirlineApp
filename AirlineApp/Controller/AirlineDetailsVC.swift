//
//  AirlineDetailsVC.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit
import SafariServices

class AirlineDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var headquarterLabel: UILabel!
    @IBOutlet weak var establishDateLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
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
            self.establishDateLabel.text = airline?.established ?? ""
        }
        
        airlineDetailViewModel.logo.subscribe{image in
            DispatchQueue.main.async {
                self.logoImageView.image = image
            }
        }
        
        airlineDetailViewModel.openSafariObserver = {url in
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func visitButtonAction(_ sender: UIButton) {
        self.airlineDetailViewModel.visitButtonClicked()
}

}
