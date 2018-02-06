//
//  BiteLevelManagerTests.swift
//  FishingForecastTests
//
//  Created by Alex on 11/24/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import XCTest
import CoreData
@testable import FishingForecast

class BiteLevelManagerTests: XCTestCase {
    
  //  var fish = Fish(type: .predatory, waterType: .cold, name: "pike", waterTemperature: [1, 20])
    
  //  var fakeForecast = DailyForecast(context: setUpInMemoryManagedObjectContext())
    
    var fish = Fish(name: "", type: 1, waterType: 1, minWaterTemperature: 10, maxWaterTemperature: 20, springWaterTemperature: [10, 20], summerWaterTemperature: [15, 25], autumnWaterTemperature: [8, 15], winterWaterTemperature: [5, 8], description: "", baitAndTackle: "")
    
    let biteLevelManager = BiteLevelManager()
    var dailyForecast = WeatherForecast(cloudinessSymbolCode: "d000", date: "2017-08-12", maxTemperature: 30, minTemperature: 20, precipitationProbability: 5, pressure: 1020, sunRise: "", sunSet: "", windDirection: "NE", windSpeed: 3, moonPhase: 250, waterTemperature: 3)
    var dailyForecast1 = WeatherForecast(cloudinessSymbolCode: "d000", date: "2017-09-12", maxTemperature: 30, minTemperature: 20, precipitationProbability: 5, pressure: 1028, sunRise: "", sunSet: "", windDirection: "NE", windSpeed: 3, moonPhase: 250, waterTemperature: 3)
    var dailyForecast2 = WeatherForecast(cloudinessSymbolCode: "d000", date: "2017-10-12", maxTemperature: 30, minTemperature: 20, precipitationProbability: 5, pressure: 1022, sunRise: "", sunSet: "", windDirection: "NE", windSpeed: 3, moonPhase: 250, waterTemperature: 3)
    
    var month = 8
    
    
    func test_calculateByWind_ShouldReturnPartOfBitingLevel() {
        
        var expected = 10
        XCTAssertEqual(biteLevelManager.calculateByWind(fish, dailyForecast), expected)
        
        
        dailyForecast.windSpeed = 10
        expected = 0
        XCTAssertEqual(biteLevelManager.calculateByWind(fish, dailyForecast), expected)
        
    }
    
    func test_calculateByMoonPhase_ShouldReturnPartOfBitingLevel() {
        
        var expected = 0
        XCTAssertEqual(biteLevelManager.calculateByMoonPhase(dailyForecast), expected)
        
        dailyForecast.moonPhase = 100
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByMoonPhase(dailyForecast), expected)
        
        dailyForecast.moonPhase = 350
        expected = 0
        XCTAssertEqual(biteLevelManager.calculateByMoonPhase(dailyForecast), expected)
        
    }
    
    func test_calculateByCloudinessAndPrecipitation_ShouldReturnPartOfBitingLevel() {
        
        var expected = 0
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(dailyForecast, month), expected)
        
        dailyForecast.maxTemperature = 24
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(dailyForecast, month), expected)
        
        dailyForecast.date = "2017-07-12"
        dailyForecast.cloudinessSymbolCode = "d440"
        dailyForecast.maxTemperature = 30
        expected = 0
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(dailyForecast, month), expected)
        
        month = 1
        dailyForecast.cloudinessSymbolCode = "d000"
        dailyForecast.maxTemperature = 15
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(dailyForecast, month), expected)
    }
    
    func test_calculateByPressure_ShouldReturnPartOfBitingLevel() {
        
        var forecast = [dailyForecast, dailyForecast1, dailyForecast2]
        
        
        var dateIndex = 0
        var expected = 10
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)

        dateIndex = 2
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)

        dateIndex = 1
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
        dailyForecast.pressure = 1009
        dailyForecast1.pressure = 1009
        dailyForecast2.pressure = 1009
        forecast = [dailyForecast, dailyForecast1, dailyForecast2]
        fish.type = 2
        
        expected = 20
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
        
        fish.type = 1
        
        expected = 0
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
        dateIndex = 0
        expected = 0
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
        dateIndex = 2
        fish.type = 2
        expected = 20
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
        dailyForecast.pressure = 1031
        dailyForecast1.pressure = 1033
        dailyForecast2.pressure = 1031
        forecast = [dailyForecast, dailyForecast1, dailyForecast2]
        
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
        fish.type = 1
        
        expected = 20
        XCTAssertEqual(biteLevelManager.calculateByPressure(fish, dateIndex, forecast), expected)
        
    }
    
    
    
//    override func setUp() {
//        super.setUp()
//        fakeForecast.date = "2017-09-11"
//        fakeForecast.maxTemperature = 25
//        fakeForecast.cloudinessSymbolCode = "d000"
//        fakeForecast.minTemperature = 12
//
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//
//}
//
//func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
//    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
//
//    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
//
//    do {
//        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
//    } catch {
//        print("Adding in-memory persistent store failed")
//    }
//
//    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
//
//    return managedObjectContext
}

