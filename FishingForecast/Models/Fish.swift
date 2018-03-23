import Foundation

struct Fish: Decodable {
    var name: String
    var type: Int
    var waterType: Int
    var minWaterTemperature: Int
    var maxWaterTemperature: Int
    var springWaterTemperature: [Int]
    var summerWaterTemperature: [Int]
    var autumnWaterTemperature: [Int]
    var winterWaterTemperature: [Int]
    var goodMonthsOfBiting: [Int]
    var theBestMonthsOfBiting: [Int]
    var description: String
    var baitAndTackle: String
}

struct FishJSON: Decodable {
    let fish: [Fish]
}

