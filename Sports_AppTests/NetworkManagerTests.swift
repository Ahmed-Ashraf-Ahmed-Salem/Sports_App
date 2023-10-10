//
//  NetworkManagerTests.swift
//  Sports_AppTests
//
//  Created by Ahmed Ashraf on 10/10/2023.
//

import XCTest

final class NetworkManagerTests: XCTestCase {
    var networkManager: Network = NetworkManager()
    func test_Event_Returns_True(){
        let expectationObj = expectation(description: "waiting for the API")
        var eventTrue: [Event]? = nil
        var errorTrue: Error? = nil
        networkManager.getEvents(leagueId: 152, chosen_sport: "football") { event, error in
            eventTrue = event
            errorTrue = error
            expectationObj.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(eventTrue)
        XCTAssertGreaterThan(eventTrue!.count, 0, "Events count is not > 0")
        XCTAssertNil(errorTrue)
    }
    
    func test_League_Returns_True(){
        let expectationObj = expectation(description: "waiting for the API")
        var leagueTrue: [League]? = nil
        var errorTrue: Error? = nil
        networkManager.getLeagues(chosen_sport: "football", completionHandler: { league, error in
            leagueTrue = league
            errorTrue = error
            expectationObj.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(leagueTrue)
        XCTAssertGreaterThan(leagueTrue!.count, 0, "Events count is not > 0")
        XCTAssertNil(errorTrue)
    }
    
    func test_Teams_Returns_True(){
        let expectationObj = expectation(description: "waiting for the API")
        var teamTrue: [Team]? = nil
        var errorTrue: Error? = nil
        networkManager.getTeams(LeagueId: 152, chosen_sport: "football", completionHandler: { team, error in
            teamTrue = team
            errorTrue = error
            expectationObj.fulfill()
        })
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(teamTrue)
        XCTAssertGreaterThan(teamTrue!.count, 0, "Events count is not > 0")
        XCTAssertNil(errorTrue)
    }
    
    func test_Get_Latest_Events(){
        let expectationObj = expectation(description: "waiting for the API")
        var eventTrue: [Event]? = nil
        var errorTrue: Error? = nil
        networkManager.getLatestEvents(leagueId: 152, chosen_sport: "football") { event, error in
            eventTrue = event
            errorTrue = error
            expectationObj.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(eventTrue)
        XCTAssertGreaterThan(eventTrue!.count, 0, "Events count is not > 0")
        XCTAssertNil(errorTrue)
    }
}
