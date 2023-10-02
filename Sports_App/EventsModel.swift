//
//  EventsModel.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 02/10/2023.
//

import Foundation

struct Events: Codable{
    var success: Int?
    var result: [Event]?
}

struct Event: Codable{
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let event_away_team: String?
    let home_team_logo: String?
    let away_team_logo:String?
    let league_logo: String?
    let event_final_result: String?
}
