//
//  TeamModel.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 03/10/2023.
//

import Foundation
struct Teams : Codable{
    var success: Int?
    var result: [Team]?
}
struct Team : Codable {
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
}
struct Player : Codable {
    var player_key : Int?
    var player_name : String?
    var player_image : String?
}



/* "team_key": 4973,
"team_name": "Torino",
"team_logo": "https://apiv2.allsportsapi.com/logo/4973_torino.jpg",*/
