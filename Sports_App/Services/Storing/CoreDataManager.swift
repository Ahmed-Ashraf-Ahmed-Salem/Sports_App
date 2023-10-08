//
//  CoreDataManager.swift
//  Sports_App
//
//  Created by Malak Samir on 30/09/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager : CoreDataProtocol{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoriteArray = [FavoriteLeagues]()

    func addingToCoreData(league:League) {
        let favEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeagues", in: context)!
        let favLeague = NSManagedObject(entity: favEntity, insertInto: context) as! FavoriteLeagues
        //adding favorite attribute
        
        favLeague.setValue( league.league_key, forKey: "league_key")
         favLeague.setValue(league.league_name, forKey: "league_name")
        favoriteArray.append(favLeague)
        
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }

    }
    
    func loadFromCoreData()->[FavoriteLeagues]{
        let request :NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        do {
            favoriteArray = try context.fetch(request)
        }
        catch{
            print(error.localizedDescription)
        }
        return favoriteArray

    }
    func deleteFromCoreData(key:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"FavoriteLeagues")
                fetchRequest.predicate = NSPredicate(format: "league_key = %@", "\(key)")
        do
        {
            let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]

            for entity in fetchedResults! {

                context.delete(entity)
           }
            do{
                try context.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        catch _ {
            print("Could not delete")

        }
    }
    
}
