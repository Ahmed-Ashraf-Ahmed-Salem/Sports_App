//
//  LeagueDetailsViewModel.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 09/10/2023.
//

import Foundation

class LeagueDetailsViewModel{
    var teamsArray: [Team]? {
        didSet {
            bindingData(teamsArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    var resultArray: [Event]? {
        didSet {
            bindingResult(resultArray, nil)
        }
    }
    var resultError: Error? {
        didSet {
            bindingResult(nil, error)
        }
    }
    
    let apiService: NetworkManager
    
    var bindingData: (([Team]?,Error?) -> Void) = {_, _ in }
    var bindingResult: (([Event]?,Error?) -> Void) = {_, _ in }
    
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
    
    func getLeaguesEvents(leagueID: Int, chosen_sport: String){
        NetworkManager.getEvents(leagueId: leagueID, chosen_sport: chosen_sport) { events, error in
            if let events = events{
                self.resultArray = events
            }
        }
    }

    func getLatestEvents(leagueID: Int, chosen_sport: String){
        NetworkManager.getLatestEvents(leagueId: leagueID, chosen_sport: chosen_sport) { events, error in
            if let events = events{
                self.resultArray = events
            }
        }
    }
 
    func getEvents() -> [Event]?{
        return resultArray
    }
    
    func getEvent(indexPath: IndexPath) -> Event?{
        return resultArray?[indexPath.row]
    }
}
