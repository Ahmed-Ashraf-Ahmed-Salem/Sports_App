//
//  NetworkProtocol.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 02/10/2023.
//

import Foundation

protocol Network{
    static func getEvents(leagueId: Int , chosen_sport : String, completion:(([Event]?, Error?) -> Void)?)
    static func getLeagues(chosen_sport : String , completionHandler : @escaping([League]?,Error?)-> Void)
    static func getTeams(LeagueId : Int,chosen_sport : String , completionHandler : @escaping([Team]?,Error?)-> Void)
    static func getLatestEvents(leagueId: Int, chosen_sport : String, completion:(([Event]?, Error?) -> Void)?) 

}
