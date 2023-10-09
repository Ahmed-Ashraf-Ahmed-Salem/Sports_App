//
//  FavouritesViewModel.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 09/10/2023.
//

import Foundation
import SystemConfiguration


class FavouritesViewModel{
    var coreDataManger = CoreDataManager()
    
    var favouriteArray: [FavoriteLeagues]? {
        didSet {
            bindingData()
        }
    }
    var error: Error? {
        didSet {
            bindingData()
        }
    }
    
    var bindingData: (() -> Void) = {}
    
    func getdata(){
        coreDataManger.loadFromCoreData()
        self.favouriteArray = coreDataManger.favoriteArray
    }
    
    func getLeagues() -> [FavoriteLeagues]?{
        return favouriteArray
    }
    
    func getLeague(indexPath: IndexPath) -> FavoriteLeagues?{
        return favouriteArray?[indexPath.row]
    }
    
    func isOnline() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
}
