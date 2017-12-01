import Foundation

struct BiteLevelManager {
    
    let forecast : DailyForecast
    let fish : Fish
    
    init(forecast: DailyForecast, fish: Fish) {
        self.forecast = forecast
        self.fish = fish
    }
    
    func calculateLevel() -> Int {
        let criticalWindSpeed = 9
        var biteLevel = 10
        
        if forecast.windSpeed > criticalWindSpeed {
            return biteLevel
        }
        
        
        biteLevel += calculateByWind()
        biteLevel += calculateByMoonPhase()
   //     biteLevel += calculateByCloudinessAndPrecipitation()
        
        return biteLevel
    }
    
    func calculateByWind() -> Int {
        
        var levelAddend = 0
        let negativeWindDirectionsForWarmWaterFish = ["N", "NE"]
        let positiveWindSpeed = 1..<8
        
        if fish.waterType == 2{
            levelAddend += 10
        } else {
            if forecast.windDirection != negativeWindDirectionsForWarmWaterFish[0] || forecast.windDirection != negativeWindDirectionsForWarmWaterFish[1] {
                levelAddend += 10
            }
        }
        if positiveWindSpeed.contains(Int(forecast.windSpeed)) {
            levelAddend += 10
        }
        return levelAddend
    }
    
    func calculateByMoonPhase() -> Int {
        
        let positiveMoonPhases = [80..<160, 260..<340]
        
        if positiveMoonPhases[0].contains(Int(forecast.moonPhase)) || positiveMoonPhases[1].contains(Int(forecast.moonPhase)) {
            return 10
        }
        return 0
    }
    
//    func calculateByCloudinessAndPrecipitation() -> Int {
//        let summerMonthes = [06, 07, 08]
//        let weather = ImageManager.getWeatherImageBy(forecast.cloudinessSymbolCode!).description
//        
//        let maxSummerTemperature = 25
//        let month = DateManager.getMonthBy(date: DateManager.getDateBy(string: forecast.date!)!)
//        
//        for summerMonth in summerMonthes {
//            if summerMonth == month && forecast.maxTemperature > maxSummerTemperature {
//                switch weather {
//                case "Clear":
//                    return 0
//                case "OvercastRain":
//                    return 0
//                case "ThunderstormRain":
//                    return 0
//                default:
//                    return 10
//                }
//            } else if summerMonth == month {
//                switch weather {
//                case "Overcast":
//                    return 0
//                case "OvercastRain":
//                    return 0
//                case "ThunderstormRain":
//                    return 0
//                default:
//                    return 10
//                }
//            }
//        }
//        switch weather {
//        case "Overcast":
//            return 0
//        case "OvercastRain":
//            return 0
//        case "ThunderstormRain":
//            return 0
//        case "OvercastWetSnow":
//            return 0
//        case "OvercastSnow":
//            return 0
//        case "OvercastLightRain":
//            return 0
//        default:
//            return 10
//        }
//        
//    }
}
