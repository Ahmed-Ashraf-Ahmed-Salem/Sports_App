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
    
    var leagueeeViewModel: LeagueViewModel! = LeagueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        LeagueTableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        
        leagueeeViewModel?.getAllLeagues(chosen_Sports: chosen_Sports)
        leagueeeViewModel?.bindingData =  { leagues, error in
        DispatchQueue.main.async {
            self.LeagueTableView.reloadData()
        }
    
    if let error = error{
        print(error.localizedDescription)
    }
}
        // Do any additional setup after loading the view.
    }

}
extension LeagueVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueeeViewModel.getLeagues()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeagueTableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        cell.setUpCell(league: leagueeeViewModel.getLeague(indexPath: indexPath)!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "leagueEvents") as! TheLeaguesDetailsViewController
        vc.leagueID = leagueeeViewModel.getLeague(indexPath: indexPath)?.league_key ?? 207
        vc.l = leagueeeViewModel.getLeague(indexPath: indexPath)
        vc.chosen_sport = self.chosen_Sports
 //       print(allLeagues[indexPath.row].league_key ?? 0 )
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
