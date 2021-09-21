//
//  CDAirline+CoreDataProperties.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 21September//2021.
//
//

import Foundation
import CoreData


extension CDAirline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAirline> {
        return NSFetchRequest<CDAirline>(entityName: "CDAirline")
    }

    @NSManaged public var id: Double
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var slogan: String?
    @NSManaged public var website: String?
    @NSManaged public var headQuaters: String?
    @NSManaged public var established: String?
    @NSManaged public var logo: String?

}

extension CDAirline : Identifiable {

}
