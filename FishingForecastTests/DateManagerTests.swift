//
//  DateManagerTests.swift
//  FishingForecastTests
//
//  Created by Alex on 11/16/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import XCTest
@testable import FishingForecast

class DateManagerTests: XCTestCase {
    
    
    
    func test_getMonthBy_ShouldGetNameOfMonthByStringDate() {
        
        let stringDate = "2017-10-15"
        
        let expected = "октября"
        XCTAssertEqual(DateManager.getMonthBy(string: stringDate), expected)
        
    }
    
    func test_getDateBy_ShouldGetDateByString() {
        let stringDate = "2017-11-14"
        
        let expectedYear = 2017
        let expectedMonth = 11
        let expectedDay = 14
        
        let date = DateManager.getDateBy(string: stringDate)!
        let calendar = Calendar.current
        
        XCTAssertEqual(calendar.component(.year, from: date), expectedYear)
        XCTAssertEqual(calendar.component(.month, from: date), expectedMonth)
        XCTAssertEqual(calendar.component(.day, from: date), expectedDay)
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
