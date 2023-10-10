//
//  LeagueDetailsViewModelTests.swift
//  Sports_AppTests
//
//  Created by Ahmed Ashraf on 10/10/2023.
//

import XCTest

final class LeagueDetailsViewModelTests: XCTestCase {

    private var leagueDetailsViewModel: LeagueDetailsViewModel?
    
    override func setUp() {
        super.setUp()
        self.leagueDetailsViewModel = LeagueDetailsViewModel(coreDataManager: nil)
        self.leagueDetailsViewModel?.networkManager = MockNetworkManager()
    }
    override func tearDown() {
        super.tearDown()
        
    }
    
    func test_Get_Teams(){
        leagueDetailsViewModel?.getLeagueTeams(LeagueId: 152, chosen_sport: "football")
        XCTAssertEqual(leagueDetailsViewModel?.getTeams()?.count, 1)
        XCTAssertNotEqual(leagueDetailsViewModel?.getTeams()?.count, 5)
    }
    
    func test_Get_Upcoming_Events(){
        leagueDetailsViewModel?.getLeaguesEvents(leagueID: 152, chosen_sport: "football")
        XCTAssertEqual(leagueDetailsViewModel?.getEvents()?.count, 2)
        XCTAssertNotEqual(leagueDetailsViewModel?.getEvents()?.count, 5)
    }
    
    func test_Get_Latest_Events(){
        leagueDetailsViewModel?.getLeaguesEvents(leagueID: 152, chosen_sport: "football")
        XCTAssertEqual(leagueDetailsViewModel?.getEvents()?.count, 2)
        XCTAssertNotEqual(leagueDetailsViewModel?.getEvents()?.count, 5)
    }
}
