//
//  PersistenceManager.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 21September//2021.
//

import Foundation

import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()

    lazy var container: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "AirlineApp")
        container.loadPersistentStores { (storeDescription, error) in
            if error != nil {
                fatalError(error!.localizedDescription)
            }
        }
        // this app is not intended to use undo functionality so doing so reduce application resource requirement
        container.viewContext.undoManager = nil
        return container
    } ()
    
   private init() {
    
    }
    func save( ){
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            }
            catch {
                print("error: ", error)
            }
        }
    }
    
 
}

//MARK:- Collections
extension PersistenceManager {
    func getAllAirlines() -> [CDAirline]{
    let request : NSFetchRequest<CDAirline> = CDAirline.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    do {
            return try container.viewContext.fetch(request)
            
        }catch {
        print("error", error.localizedDescription)
     }
    return []
    }
    
    func addNewAirline(airline: Airline,context:NSManagedObjectContext ) throws {
        let cdAirline = CDAirline(context: container.viewContext)
        cdAirline.id = airline.id ?? 0
        cdAirline.name = airline.name
        cdAirline.country = airline.country ?? ""
        cdAirline.slogan = airline.slogan ?? ""
        cdAirline.logo = airline.logo ?? ""
        cdAirline.established = airline.established ?? ""
        cdAirline.headQuaters = airline.headQuaters ?? ""
        
        try context.save()
    }
    
    func addAirlines(airlines: [Airline]){
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = container.viewContext
        privateMOC.perform {
            airlines.forEach { airline in
                try? self.addNewAirline(airline: airline,context: privateMOC)
            }
        }
        
    }
    
    func deleteAllAirlines(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDAirline")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        _ = try? container.viewContext.execute(deleteRequest)
            
    }
    
}
