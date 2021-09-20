//
//  AirlineDetailsViewModel.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 20September//2021.
//

import Foundation
import UIKit.UIImage

class AirlineDetailsViewModel {
    var airline: Observable<Airline>!
    var logo: Observable<UIImage>!
    var openSafariObserver: ((_ url: URL) -> Void)?
    
    init(model: Airline) {
        airline = Observable(model)
        downloadLogo(fromURL: model.logo)
    }
    
    func downloadLogo(fromURL url: String?) {
        let placeholderLogo = UIImage(named: "airline-logo-placeholder") ?? UIImage()
        logo = Observable(placeholderLogo)
        guard let imageUrl = url else {return}
            NetworkManager.shared.downloadImage(from: imageUrl) { image in
                self.logo.value = image
            }
    }
    
    func visitButtonClicked(){
        guard let websiteUrlString = airline.value?.website else {return}
        guard let websiteUrl = URL(string: websiteUrlString),
              var websiteUrlComponent = URLComponents(string: websiteUrlString) else {return}
        if websiteUrl.scheme == nil {
            websiteUrlComponent.scheme = "https"
        }
        guard let url = websiteUrlComponent.url else {return}
        openSafariObserver?(url)
    }
}
