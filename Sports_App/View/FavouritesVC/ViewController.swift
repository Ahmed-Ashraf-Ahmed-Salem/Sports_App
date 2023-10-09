//
//  ViewController.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 09/10/2023.
//

import UIKit
import CoreData
import SystemConfiguration


class FavouritesScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var favoriteArray = [FavoriteLeagues]()
    var coreDataManger = CoreDataManager()
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewWillAppear(_ animated: Bool) {

        loadFromCoreData()
       
        print("will")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadFromCoreData()
        favoriteArray = coreDataManger.favoriteArray

        print("did")
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        
        cell.leagueName.text = favoriteArray[indexPath.row].league_name
        let unencodedData = favoriteArray[indexPath.row].league_logo
        let image = UIImage(data: unencodedData!)
        cell.leagueImage.image = image
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isOnline(){
            let vc = storyboard?.instantiateViewController(identifier: "leagueEvents") as! TheLeaguesDetailsViewController
            vc.leagueID = Int(favoriteArray[indexPath.row].league_key )
            
            print(Int(favoriteArray[indexPath.row].league_key ))
            vc.chosen_sport = favoriteArray[indexPath.row].sport_type ?? "no type"
            print(vc.chosen_sport)
            
            self.present(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: "No Internet Connection", message: "you don't have connection please check your network and try again!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
          coreDataManger.deleteFromCoreData(key: Int(favoriteArray[indexPath.row].league_key))
          //coreDataManger.deleteByIndexPath(index: indexPath.row)
          
          self.tableView.deleteRows(at: [indexPath], with: .automatic)

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
        self.tableView.reloadData()
    }
    
    func isOnline() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
  

}
