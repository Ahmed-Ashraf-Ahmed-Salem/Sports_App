//
//  LeagueViewModelTests.swift
//  Sports_AppTests
//
//  Created by Ahmed Ashraf on 10/10/2023.
//

import XCTest

final class LeagueViewModelTests: XCTestCase {
    private var leagueViewModel: LeagueViewModel?
    
    override func setUp() {
        super.setUp()
        self.leagueViewModel = LeagueViewModel()
        self.leagueViewModel?.networkManager = MockNetworkManager()
    }
    override func tearDown() {
        super.tearDown()
        
    }
    func test_Get_Leagues(){
        leagueViewModel?.getAllLeagues(chosen_Sports: "football")
        XCTAssertEqual(leagueViewModel?.getLeagues()?.count, 10)
        XCTAssertNotEqual(leagueViewModel?.getLeagues()?.count, 5)
    }
}
