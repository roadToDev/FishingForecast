import Foundation

struct Fish: Decodable {
    
    var name: String
    var type: Int
    var waterType: Int
    var waterTemperature: [Int]
    var description: String
    var baitAndTackle: String
    
}

struct FishJSON: Decodable {
    let fish: [Fish]
}

