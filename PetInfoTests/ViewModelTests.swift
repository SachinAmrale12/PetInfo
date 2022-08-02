//
//  ViewModelTests.swift
//  PetInfoTests
//
//  Created by Sachin on 02/08/22.
//

import XCTest
@testable import PetInfo

class ViewModelTests: XCTestCase {
    
    lazy var viewModel = MainViewModel()
    
    func testValidOfficeHours() {
        let date = Date.getDateForTime(time: 14)
        XCTAssertTrue(date.startTime <= date && date <= date.endTime)
    }
    
    func testInvalidOfficeHours() {
        let date = Date.getDateForTime(time: 8)
        XCTAssertFalse(date < date.startTime && date > date.endTime)
    }
    
    func testCheckTimeExistTrue() {
        let date = Date.getDateForTime(time: 11)
        let result = viewModel.checkTimeExist(date: date)
        XCTAssertTrue(result)
    }
    
    func testCheckTimeExistFalse() {
        let date = Date.getDateForTime(time: 7)
        let result = viewModel.checkTimeExist(date: date)
        XCTAssertFalse(result)
    }
    
    func testGetConfigData() {
        let expectation = XCTestExpectation.init(description: "Should fetch the config data")
        viewModel.getConfigData { settings, error in
            if let _ = settings {
                expectation.fulfill()
            } else {
                XCTFail("failed")
            }
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func testGetPetDetails() {
        let expectation = XCTestExpectation.init(description: "Should fetch the pets data")
        viewModel.getPetDetails { pets, error in
            if let _ = pets {
                expectation.fulfill()
            } else {
                XCTFail("failed")
            }
        }
        wait(for: [expectation], timeout: 30)
    }
}
