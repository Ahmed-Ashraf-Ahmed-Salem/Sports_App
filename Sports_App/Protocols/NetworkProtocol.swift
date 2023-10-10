//
//  NetworkProtocol.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 02/10/2023.
//

import Foundation

protocol Network{
    func getEvents(leagueId: Int , chosen_sport : String, completion:(([Event]?, Error?) -> Void)?)
    func getLeagues(chosen_sport : String , completionHandler : @escaping([League]?,Error?)-> Void)
    func getTeams(LeagueId : Int,chosen_sport : String , completionHandler : @escaping([Team]?,Error?)-> Void)
    func getLatestEvents(leagueId: Int, chosen_sport : String, completion:(([Event]?, Error?) -> Void)?) 

}
