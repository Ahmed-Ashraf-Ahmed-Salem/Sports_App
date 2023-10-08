//
//  TeamsViewModel.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 08/10/2023.
//

import Foundation

class TeamsViewModel{
    var teamsArray: [Team]? {
        didSet {
            bindingData()
        }
    }
    var error: Error? {
        didSet {
            bindingData()
        }
    }
    
    let apiService: NetworkManager
    var bindingData: (() -> Void) = {}
    
    init(apiService: NetworkManager = NetworkManager()) {
        self.apiService = apiService
    }
    
    func getLeagueTeams (LeagueId: Int, chosen_sport: String){
        NetworkManager.getTeams(LeagueId: LeagueId, chosen_sport: chosen_sport) { teamslist, error in
            if let allTeams = teamslist {
                self.teamsArray = allTeams
            }
        }
    }
    
    func getTeams() -> [Team]?{
        return teamsArray
    }
    
    func getTeam(indexPath: IndexPath) -> Team?{
        return teamsArray?[indexPath.row]
    }
     
}
