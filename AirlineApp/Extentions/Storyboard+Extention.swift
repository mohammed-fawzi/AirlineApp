//
//  Storyboard+Extention.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 20September//2021.
//

import UIKit

extension UIStoryboard {
    func mainStoryboard()-> UIStoryboard{
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    func instantiateAirlineDetailsVC()-> AirlineDetailsVC {
        
        return mainStoryboard().instantiateViewController(withIdentifier: ViewControllers.airlineDetailVC.rawValue) as! AirlineDetailsVC
    }
}
