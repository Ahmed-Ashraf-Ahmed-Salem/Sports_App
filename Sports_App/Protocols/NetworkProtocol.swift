//
//  NetworkProtocol.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 02/10/2023.
//

import Foundation

protocol Network{
    static func getEvents(leagueId: Int, completion:(([Event]?, Error?) -> Void)?)
}
