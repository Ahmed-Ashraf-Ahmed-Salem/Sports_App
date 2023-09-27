//
//  LeagueVC.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 28/09/2023.
//

import UIKit

class LeagueVC: UIViewController {

    @IBOutlet weak var LeagueTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        LeagueTableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        // Do any additional setup after loading the view.
    }

}
extension LeagueVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeagueTableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        if indexPath.row == 0 {
            cell.leagueName.text = "English Northern Premier League"
        }
        else {cell.leagueName.text = "English National League North"}
        return cell
    }
    
    
}
