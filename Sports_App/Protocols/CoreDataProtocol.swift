//
//  CoreDataProtocol.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 08/10/2023.
//

import Foundation

protocol CoreDataProtocol{
    func addingToCoreData(league:League)
    func loadFromCoreData()->[FavoriteLeagues]
    func deleteFromCoreData(key:Int)
}
