//
//  LeagueVC.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 28/09/2023.
//

import UIKit

class LeagueVC: UIViewController {
    var allLeagues : [League] = []
    var chosen_Sports : String = ""
    @IBOutlet weak var LeagueTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        LeagueTableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        getAllLeagues()
        // Do any additional setup after loading the view.
    }

}
extension LeagueVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeagueTableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        cell.leagueName.text = allLeagues[indexPath.row].league_name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "leagueEvents") as! TheLeaguesDetailsViewController
        vc.leagueID = allLeagues[indexPath.row].league_key ?? 207
        print(allLeagues[indexPath.row].league_key ?? 0 )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func getAllLeagues(){
        NetworkManager.getLeagues(chosen_sport: chosen_Sports) { leagueList, error in
            if let leagues = leagueList{
                self.allLeagues = leagues
                self.LeagueTableView.reloadData()
            }
            
        }
    }
}

