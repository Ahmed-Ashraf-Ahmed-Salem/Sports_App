//
//  FavouritesScreen.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 28/09/2023.
//

import UIKit

class FavouritesScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favouriteViewModel: FavouritesViewModel = FavouritesViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteViewModel.getdata()

        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        favouriteViewModel.getdata()
        favouriteViewModel.bindingData = {}
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteViewModel.getLeagues()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        self.favouriteViewModel.getdata()
        cell.leagueName.text = favouriteViewModel.getLeague(indexPath: indexPath)?.league_name
        let unencodedData = favouriteViewModel.getLeague(indexPath: indexPath)?.league_logo
        let image = UIImage(data: unencodedData!)
        cell.leagueImage.image = image
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if favouriteViewModel.isOnline(){
            self.favouriteViewModel.getdata()
            let vc = storyboard?.instantiateViewController(identifier: "leagueEvents") as! TheLeaguesDetailsViewController
            vc.leagueID = Int(favouriteViewModel.getLeague(indexPath: indexPath)?.league_key ?? 0 )
           
            print(Int(favouriteViewModel.getLeague(indexPath: indexPath)?.league_key ?? 0 ))
            vc.chosen_sport = favouriteViewModel.getLeague(indexPath: indexPath)?.sport_type ?? "no type"
            print(vc.chosen_sport)
            
            self.present(vc, animated: true)
        }
        else{
            self.favouriteViewModel.getdata()
            let alert = UIAlertController(title: "No Internet Connection", message: "you don't have connection please check your network and try again!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          let alert = UIAlertController(title: "Delete Event", message: "Are You Sure You Want To Delete This Event?", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
              self.favouriteViewModel.coreDataManger.deleteByIndexPath(index: indexPath.row)
              self.favouriteViewModel.getdata()
              self.tableView.deleteRows(at: [indexPath], with: .automatic)
          }))
          alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)

      }
    }
  
    
    
}
