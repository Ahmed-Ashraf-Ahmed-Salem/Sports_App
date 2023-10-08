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
   private static func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat =  "yyyy-MM-dd"
       let result = formatter.string(from: date)
               return result
    }
    private static func getNextWeekDate() -> String{
        let currentDate = Date()
        let calendar = Calendar.current
        let nextWeekDate = calendar.date(byAdding: .day, value: 14, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nextWeekDateString = dateFormatter.string(from: nextWeekDate!)
        return nextWeekDateString
    }
    private static func getLasttWeekDate() -> String{
        let currentDate = Date()
        let calendar = Calendar.current
     
        let lastWeekDate  = calendar.date(byAdding: .day, value: -7, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let lastWeekDateString = dateFormatter.string(from: lastWeekDate!)
         return lastWeekDateString
    }
    

    //let currentWeek = calendar.component(.weekOfYear, from: currentDate)
    
    static func getLatestEvents(leagueId: Int, chosen_sport : String, completion:(([Event]?, Error?) -> Void)?) {
        let currentdate =  getDate()
        let lastWeekDate = getLasttWeekDate()
        let urlFile = "https://apiv2.allsportsapi.com/\(chosen_sport)/?met=Fixtures&leagueId=\(leagueId)&from=\(lastWeekDate)&to=\(currentdate)&APIkey=c820cb931b4418392a78bd8187a08f12b9e7803d64a36542c746f1f5cda4bb38"
        print(urlFile)
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
    static func getEvents(leagueId: Int, chosen_sport : String, completion:(([Event]?, Error?) -> Void)?) {
        let currentdate =  getDate()
        let nextWeekDate = getNextWeekDate()
        let urlFile = "https://apiv2.allsportsapi.com/\(chosen_sport)/?met=Fixtures&leagueId=\(leagueId)&from=\(currentdate)&to=\(nextWeekDate)&APIkey=c820cb931b4418392a78bd8187a08f12b9e7803d64a36542c746f1f5cda4bb38"
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
    static func getLeagues(chosen_sport : String , completionHandler : @escaping([League]?,Error?)-> Void){
       
       let leagueURL = "https://apiv2.allsportsapi.com/\(chosen_sport)/?met=Leagues&APIkey=f0b6949f038454e6ea83893c1a14440a4d4dc977428cb739465fd63304157032"
        
        AF.request(leagueURL,method: .post,
                   parameters: nil,
                   encoding: URLEncoding.default, headers: nil).response{
            (response:DataResponse)  in
            switch(response.result) {
            case .success(let value):
                do{
                    let allLeagues = try JSONDecoder().decode(Leagues.self, from: value ?? Data())
                    completionHandler(allLeagues.result,nil)
                } catch (let error){
                    print(error)
                    completionHandler(nil, error)
                }
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    static func getTeams(LeagueId : Int ,chosen_sport : String  , completionHandler : @escaping([Team]?,Error?)-> Void){
        let urlFile = "https://apiv2.allsportsapi.com/\(chosen_sport)?met=Teams&leagueId=\(LeagueId)&APIkey=f0b6949f038454e6ea83893c1a14440a4d4dc977428cb739465fd63304157032"
        AF.request(urlFile,method: .post,
                   parameters: nil,
                   encoding: URLEncoding.default, headers: nil).response{
            (response:DataResponse)  in
            switch(response.result) {
            case .success(let value):
                do{
                    let LeagueTeams = try JSONDecoder().decode(Teams.self, from: value ?? Data())
                    completionHandler(LeagueTeams.result,nil)
                } catch (let error){
                    print(error)
                    completionHandler(nil, error)
                }
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
}
