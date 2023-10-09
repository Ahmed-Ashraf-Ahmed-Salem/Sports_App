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
   
    
    var fav: Bool?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoriteArray = [FavoriteLeagues]()

    func checkFav(id:Int)->Bool{
        self.loadFromCoreData()
        for favorite in favoriteArray{
            if(favorite.league_key == id){
                return true
            }
        }
        return false
    }
    func addingToCoreData(l:League , chosen_sport :String) {
        self.loadFromCoreData()
        let favEntity = NSEntityDescription.entity(forEntityName: "FavoriteLeagues", in: context)!
        let favLeague = NSManagedObject(entity: favEntity, insertInto: context) as! FavoriteLeagues
        
        favLeague.league_name = l.league_name
        favLeague.league_key = Int32(l.league_key!)
        favLeague.sport_type = chosen_sport
        
        let imageUrl = URL(string: l.league_logo!)
 //       print(imageUrl)
        let imageData = try! Data(contentsOf: imageUrl!)

        let image = UIImage(data: imageData)
        let img = image!.pngData();

        favLeague.league_logo = img; //<--Image data is stored in the core data entity.

        
        print(favLeague.league_name)
        favoriteArray.append(favLeague)
        
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }

    }
    
    func loadFromCoreData() {
        self.favoriteArray = []
        let request :NSFetchRequest<FavoriteLeagues> = FavoriteLeagues.fetchRequest()
        do {
            self.favoriteArray = try context.fetch(request)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func deleteFromCoreData(key:Int){
        for i in 0...favoriteArray.count-1{
            print(favoriteArray.count-1)
            print(i)
            if(favoriteArray[i].league_key == Int32(key)){
                context.delete(favoriteArray[i])
                
                favoriteArray.remove(at:i)
                
                do{
                    try context.save()
                    break
                }
                catch{
                    print(error.localizedDescription)
                    break
                }
            }
        }
        
    }
        func deleteByIndexPath(index:Int){
            context.delete(favoriteArray[index])

            self.favoriteArray.remove(at: index)
              do{
                  try context.save()
              }
              catch{
                  print(error.localizedDescription)
              }
        }

}
