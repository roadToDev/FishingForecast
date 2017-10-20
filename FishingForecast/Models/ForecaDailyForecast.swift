import Foundation

struct ForecaDailyForecast: Decodable {
    
    var averageCloudiness : Int
    var dayLength : Int
    var date : String
    var sunRise : String
    var sunSet : String
    var minPressure : Int
    var precipitationProbability : Int
    var maxPressure : Int
    var minHumidity : Int
    var maxHumidity : Int
    var symbolCode : String
    var minTemperature : Int
    var thunderProbability : Int
    var maxTemperature : Int
    var uvIndex : Int
    var windDirectionInDegrees : Int
    var windDirection : String
    var windSpeed : Int
    var moonRise : String
    var moonSet : String
    var p : Double
    var moonPhase : Int
    
    private enum CodingKeys : String, CodingKey {
        case averageCloudiness = "ca", dayLength = "dl", date = "dt", precipitationProbability = "pp", minPressure = "pn", maxPressure = "px", minTemperature = "tn", maxTemperature = "tx", uvIndex = "uv", windDirection = "wn", symbolCode = "s", minHumidity = "rn", maxHumidity = "rx", sunSet = "ss", sunRise = "sr", thunderProbability = "tp", windDirectionInDegrees = "wd", windSpeed = "ws", p, moonRise = "mr", moonSet = "ms", moonPhase = "mp"
    }
}
