import Foundation

struct BiteLevelManager {
    
    func calculateLevel() {
//        var forecast = ForecaDailyForecast(averageCloudiness: 70, dayLength: 260, date: "", sunRise: <#T##String#>, sunSet: <#T##String#>, minPressure: <#T##Int#>, precipitationProbability: <#T##Int#>, maxPressure: <#T##Int#>, minHumidity: <#T##Int#>, maxHumidity: <#T##Int#>, symbolCode: <#T##String#>, minTemperature: <#T##Int#>, thunderProbability: <#T##Int#>, maxTemperature: <#T##Int#>, uvIndex: <#T##Int#>, windDirectionInDegrees: <#T##Int#>, windDirection: <#T##String#>, windSpeed: <#T##Int#>, moonRise: <#T##String#>, moonSet: <#T##String#>, p: <#T##Double#>, moonPhase: 234)
        var fish = Fish(type: .peacefull, waterType: .cold, name: "elec", waterTemperature: [8, 12])
        
        fish.type = .predatory
        
        
    }
    
}

struct Fish {
    
    var type: FishType
    var waterType: WaterType
    var name: String
    var waterTemperature: [Int]
    
}

enum WaterType: String {
    case warm
    case cold
}
enum FishType: String {
    case peacefull
    case predatory
}
