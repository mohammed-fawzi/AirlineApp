//
//  Airline.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import Foundation

struct Airline: Codable {
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
    
}
