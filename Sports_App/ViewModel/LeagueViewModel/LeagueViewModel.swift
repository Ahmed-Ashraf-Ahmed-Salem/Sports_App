//
//  LeagueViewModel.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 08/10/2023.
//

import Foundation

class LeagueViewModel{
        
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
        NetworkManager.getLeagues(chosen_sport: chosen_Sports) { leagueList, error in
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

/*
 func fetchLeagues() {
         let endPoint = "search_all_leagues.php?s=\(filterSport.strSport)"
         apiService.fetchLeagues(endPoint: endPoint) { leagues, error in
             if let leagues = leagues {
                 self.leagueArray = leagues.filter({leguaeItem in
                     return leguaeItem.strSport == self.filterSport.strSport
                 })
             }
             if let error = error {
                 self.error = error
             }
         }
     }
 */
