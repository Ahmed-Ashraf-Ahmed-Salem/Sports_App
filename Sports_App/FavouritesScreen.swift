//
//  FavouritesScreen.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 28/09/2023.
//

import UIKit
import CoreData


class FavouritesScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var favoriteArray = [FavoriteLeagues]()
    
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
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "leagueEvents") as! TheLeaguesDetailsViewController
        vc.leagueID = Int(favoriteArray[indexPath.row].league_key )
       // vc.l = favoriteArray[indexPath.row]
        //vc.chosen_sport = self.chosen_Sports
        print(favoriteArray[indexPath.row].league_key )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
          
          context.delete(favoriteArray[indexPath.row])

        self.favoriteArray.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
          do{
              try context.save()
          }
          catch{
              print(error.localizedDescription)
          }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
