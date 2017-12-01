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
    
    var fish = Fish(type: .predatory, waterType: .cold, name: "pike", waterTemperature: [1, 20])
    
    var fakeForecast = DailyForecast(context: setUpInMemoryManagedObjectContext())
    
    func test_calculateByCloudinessAndPrecipitation_ShouldGetPartLevelOfBiting() {
        
        let biteLevelManager = BiteLevelManager(forecast: fakeForecast, fish: fish)
        
        var expected = 10
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(), expected)
        
        fakeForecast.date = "2017-08-12"
        expected = 10
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(), expected)
        
        fakeForecast.date = "2017-07-12"
        fakeForecast.cloudinessSymbolCode = "d440"
        fakeForecast.maxTemperature = 30
        expected = 0
        XCTAssertEqual(biteLevelManager.calculateByCloudinessAndPrecipitation(), expected)
    }
    
    
    
    
    
    override func setUp() {
        super.setUp()
        fakeForecast.date = "2017-09-11"
        fakeForecast.maxTemperature = 25
        fakeForecast.cloudinessSymbolCode = "d000"
        fakeForecast.minTemperature = 12
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}

func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
    
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    do {
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    } catch {
        print("Adding in-memory persistent store failed")
    }
    
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    
    return managedObjectContext
}
