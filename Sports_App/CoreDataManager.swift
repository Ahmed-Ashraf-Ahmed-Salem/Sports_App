//
//  CoreDataManager.swift
//  Sports_App
//
//  Created by Malak Samir on 30/09/2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataProtocol{
    func addingToCoreData()
    func loadFromCoreData()
    func deleteFromCoreData(key:Int)
}
class CoreDataManager : CoreDataProtocol{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoriteArray = [FavoriteLeagues]()

    func addingToCoreData() {
        let favorite = FavoriteLeagues(context:context)
        //adding favorite attribute
        favoriteArray.append(favorite)
        
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }

    }
    
    func loadFromCoreData(){
        let request :NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        do {
            favoriteArray = try context.fetch(request)
        }
        catch{
            print(error.localizedDescription)
        }
        
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
