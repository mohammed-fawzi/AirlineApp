//
//  Airline.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

struct Airline: Codable, Equatable {
    var id: Double?
    var name: String
    var country: String?
    var logo: String?
    var slogan: String?
    var headQuaters: String?
    var website: String?
    var established: String?
    
    private enum CodingKeys : String, CodingKey {
        case id, name, country, logo, slogan, headQuaters = "head_quaters", website, established
        }
    
    init(id: Double?, name: String, country:String?, logo:String? ,slogan:String?, headQuaters: String?, website:String?, established:String?){
        self.id = id
        self.name = name
        self.country = country
        self.logo = logo
        self.slogan = slogan
        self.headQuaters = headQuaters
        self.website = website
        self.established = established
    }
    
    init(cdAirline: CDAirline){
        id = cdAirline.id
        name = cdAirline.name ?? ""
        country = cdAirline.country
        logo = cdAirline.logo
        slogan = cdAirline.slogan
        headQuaters = cdAirline.headQuaters
        website = cdAirline.website
        established = cdAirline.established
    }
}
