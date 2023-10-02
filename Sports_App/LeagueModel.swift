//
//  LeagueModel.swift
//  Sports_App
//
//  Created by Ziyad Qassem on 03/10/2023.
//

import Foundation
struct Leagues : Codable {
    var success: Int?
    var result: [League]?
}
struct League : Codable {

    let league_key : Int?
    let league_name : String?
    let league_logo : String?
    
}
//Name id logo YouTube link
//    {
//                "league_key": 4,
//                "league_name": "UEFA Europa League",
//                "country_key": 1,
//                "country_name": "eurocups",
//                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
//                "country_logo": null
//            },
