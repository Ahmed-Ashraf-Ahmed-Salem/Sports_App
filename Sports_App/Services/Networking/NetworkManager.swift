//
//  NetworkManager.swift
//  Sports_App
//
//  Created by Ahmed Ashraf on 02/10/2023.
//

import Foundation
import Alamofire

class NetworkManager: Network{
    /*
    func getEvents(leagueId: Int) {
        let urlFile = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(leagueId)&from=2023-01-18&to=2024-01-18&APIkey=c820cb931b4418392a78bd8187a08f12b9e7803d64a36542c746f1f5cda4bb38"
        AF.request(urlFile).responseDecodable(of: [Events].self) { response in
            switch response.result {
            case .success():
                DispatchQueue.main.async {
                    self.eventDetails.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    */
    static func getEvents(leagueId: Int, completion:(([Event]?, Error?) -> Void)?) {
        let urlFile = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(leagueId)&from=2023-01-18&to=2024-01-18&APIkey=c820cb931b4418392a78bd8187a08f12b9e7803d64a36542c746f1f5cda4bb38"
            
            AF.request(urlFile,
                       method: .post,
                       parameters: nil,
                       encoding: URLEncoding.default, headers: nil).response { (response:DataResponse)  in
                switch(response.result) {
                case .success(let value):
                    do{
                        let readEvents = try JSONDecoder().decode(Events.self, from: value ?? Data())
                        completion?(readEvents.result, nil)
                    } catch (let err){
                        print(err)
                        completion?(nil, err)
                    }
                case .failure(let err):
                    print(err)
                    completion?(nil, err)
                }
            }
        }
}
