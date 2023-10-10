//
//  LeagueViewModel.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 08/10/2023.
//

import Foundation

class LeagueViewModel{
    var networkManager: Network = NetworkManager()
    
    var leagueArray: [League]? {
        didSet {
            bindingData(leagueArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    
    let apiService: NetworkManager
    var bindingData: (([League]?,Error?) -> Void) = {_, _ in }
    
    init(apiService: NetworkManager = NetworkManager()) {
        self.apiService = apiService
    }
    
    func getAllLeagues(chosen_Sports : String){
 //       let chosen_Sports = ""
        networkManager.getLeagues(chosen_sport: chosen_Sports) { leagueList, error in
            if let leagues = leagueList{
                self.leagueArray = leagues
            }
        }
    }
    
    func getLeagues() -> [League]?{
        return leagueArray
    }
    
    func getLeague(indexPath: IndexPath) -> League?{
        return leagueArray?[indexPath.row]
    }
     
}
