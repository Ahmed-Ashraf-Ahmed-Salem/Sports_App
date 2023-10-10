//
//  LeagueVC.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 28/09/2023.
//

import UIKit

class LeagueVC: UIViewController {
    
    var chosen_Sports : String = ""
    
    @IBOutlet weak var LeagueTableView: UITableView!
    
    var leagueViewModel: LeagueViewModel! = LeagueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        LeagueTableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        
        leagueViewModel?.getAllLeagues(chosen_Sports: chosen_Sports)
        leagueViewModel?.bindingData =  { leagues, error in
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
        return leagueViewModel.getLeagues()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeagueTableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        cell.setUpCell(league: leagueViewModel.getLeague(indexPath: indexPath)!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "leagueEvents") as! TheLeaguesDetailsViewController
        vc.leagueID = leagueViewModel.getLeague(indexPath: indexPath)?.league_key ?? 207
        vc.l = leagueViewModel.getLeague(indexPath: indexPath)
        vc.chosen_sport = self.chosen_Sports
        vc.name = leagueViewModel.getLeague(indexPath: indexPath)?.league_name ?? "name not found"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
