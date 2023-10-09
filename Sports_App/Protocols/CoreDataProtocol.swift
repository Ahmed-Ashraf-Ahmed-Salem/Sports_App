//
//  CoreDataProtocol.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 08/10/2023.
//

import Foundation

protocol CoreDataProtocol{
    func addingToCoreData( l:League , chosen_sport :String)
    func loadFromCoreData()
    func deleteFromCoreData(key:Int)
    func deleteByIndexPath(index:Int)
    func checkFav(id:Int)->Bool
}
