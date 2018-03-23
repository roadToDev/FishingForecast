import Foundation

struct BiteLevelManager {
    
    func calculateLevel(_ fish: Fish, _ dateIndex: Int, _ month: Int, _ forecast: [WeatherForecast]) -> Int {
        let minBiteLevel = 10
        let criticalWindSpeed = 9
        var biteLevel = 0
        let dailyForecast = forecast[dateIndex]
        let waterTemperature = Int(forecast[dateIndex].waterTemperature)
        
        if dailyForecast.windSpeed > criticalWindSpeed {
            return minBiteLevel
        }
        
        if fish.minWaterTemperature > waterTemperature || waterTemperature > fish.maxWaterTemperature {
            return minBiteLevel
        }
        
        biteLevel += calculateByWind(fish, dailyForecast)
        biteLevel += calculateByMoonPhase(dailyForecast)
        biteLevel += calculateByCloudinessAndPrecipitation(dailyForecast, month)
        biteLevel += calculateByPressure(fish, dateIndex, forecast)
        biteLevel += calculateByWaterTemperature(fish, waterTemperature, month)
        biteLevel += calculateByMonths(fish, month)
        
        if biteLevel != 0 {
            return biteLevel
        } else {
            return minBiteLevel
        }
    }
    
    func calculateByMonths(_ fish: Fish, _ month: Int) -> Int {
        for goodMonth in fish.goodMonthsOfBiting {
            if goodMonth == month {
                return 10
            }
        }
        for bestMonth in fish.theBestMonthsOfBiting {
            if bestMonth == month {
                return 20
            }
        }
        return 0
    }
    
    func calculateByWaterTemperature(_ fish: Fish, _ waterTemperature: Int, _ month: Int) -> Int {
        let min = 0
        let max = 1
        let season = getSeason(month)
        
        switch season {
        case .spring:
            if fish.springWaterTemperature[min] <= waterTemperature && waterTemperature <= fish.springWaterTemperature[max]{
                return 10
            }
        case .summer:
            if fish.summerWaterTemperature[min] <= waterTemperature && waterTemperature <= fish.summerWaterTemperature[max]{
                return 10
            }
        case .autumn:
            if fish.autumnWaterTemperature[min] <= waterTemperature && waterTemperature <= fish.autumnWaterTemperature[max]{
                return 10
            }
        case .winter:
            if fish.winterWaterTemperature[min] <= waterTemperature && waterTemperature <= fish.winterWaterTemperature[max]{
                return 10
            }
        }
        return 0
    }
    
    func getSeason(_ month: Int) -> Season {
        let springMonths = [03, 04, 05]
        let summerMonths = [06, 07, 08]
        let autumnMonths = [09, 10, 11]
        for springMonth in springMonths {
            if month == springMonth {
                return .spring
            }
        }
        for summerMonth in summerMonths {
            if month == summerMonth {
                return .summer
            }
        }
        for autumnMonth in autumnMonths {
            if month == autumnMonth {
                return .autumn
            }
        }
        return .winter
    }
    
    func calculateByPressure(_ fish: Fish, _ dateIndex: Int, _ forecast: [WeatherForecast]) -> Int {
        
        let normalPressure: CountableRange<Int32> = 1010..<1030
        let normalPressureDifference: CountableRange<Int32> = -10..<10
        let dailyForecast = forecast[dateIndex]
        
        
        
        if dateIndex == 0 {
            let nextDayForecast = forecast[dateIndex + 1]
            let pressureDifferenceWithNextDay = dailyForecast.pressure - nextDayForecast.pressure
            
            if normalPressureDifference.contains(pressureDifferenceWithNextDay){
                return comparePressure(fish, dailyForecast.pressure, normalPressure.startIndex, normalPressure.endIndex)
            } else {
                return 0
            }
        } else if dateIndex == forecast.count - 1 {
            let previousDayForecast = forecast[dateIndex - 1]
            let pressureDifferenceWithPreDay = dailyForecast.pressure - previousDayForecast.pressure
            
            if normalPressureDifference.contains(pressureDifferenceWithPreDay){
                return comparePressure(fish, dailyForecast.pressure, normalPressure.startIndex, normalPressure.endIndex)
            } else {
                return 0
            }
        } else {
            let previousDayForecast = forecast[dateIndex - 1]
            let nextDayForecast = forecast[dateIndex + 1]
            let pressureDifferenceWithNextDay = dailyForecast.pressure - nextDayForecast.pressure
            let pressureDifferenceWithPreDay = dailyForecast.pressure - previousDayForecast.pressure
            
            if normalPressureDifference.contains(pressureDifferenceWithPreDay) && normalPressureDifference.contains(pressureDifferenceWithNextDay){
                
                return comparePressure(fish, dailyForecast.pressure, normalPressure.startIndex, normalPressure.endIndex)
                
            } else {
                return 0
            }
        }        
    }
    
    private func comparePressure(_ fish: Fish, _ dailyPressure: Int32, _ lowerPressure: Int32, _ higherPressure: Int32 ) -> Int{
        if dailyPressure < lowerPressure {
            if fish.type == 1 {
                return 0
            } else {
                return 20
            }
        } else if dailyPressure > higherPressure{
            if fish.type == 1 {
                return 20
            } else {
             return 10
            }
        } else {
            return 10
        }
    }
    
    func calculateByWind(_ fish: Fish, _ forecast: WeatherForecast) -> Int {
        
        var levelAddend = 0
        let negativeWindDirectionsForWarmWaterFish = ["N", "NE"]
        let positiveWindSpeed = 1..<8
        
        if fish.waterType == 2 {
            levelAddend += 10
        } else {
            if forecast.windDirection != negativeWindDirectionsForWarmWaterFish[0] && forecast.windDirection != negativeWindDirectionsForWarmWaterFish[1] {
                levelAddend += 10
            }
        }
        if positiveWindSpeed.contains(Int(forecast.windSpeed)) {
            levelAddend += 10
        }
        return levelAddend
    }
    
    func calculateByMoonPhase(_ forecast: WeatherForecast) -> Int {
        
        let positiveMoonPhases = [80..<160, 260..<340]
        
        if positiveMoonPhases[0].contains(Int(forecast.moonPhase)) || positiveMoonPhases[1].contains(Int(forecast.moonPhase)) {
            return 20
        }
        return 0
    }
    
    func calculateByCloudinessAndPrecipitation(_ forecast: WeatherForecast, _ month: Int) -> Int {
        let summerMonths = [06, 07, 08]
        let weather = ImageManager.getWeatherImageBy(forecast.cloudinessSymbolCode).description
        let maxSummerTemperature = 25

        for summerMonth in summerMonths {
            if summerMonth == month && forecast.maxTemperature > maxSummerTemperature {
                switch weather {
                case "Clear":
                    return 0
                case "OvercastRain":
                    return 0
                case "ThunderstormRain":
                    return 0
                default:
                    return 10
                }
            } else if summerMonth == month {
                switch weather {
                case "Overcast":
                    return 0
                case "OvercastRain":
                    return 0
                case "ThunderstormRain":
                    return 0
                default:
                    return 10
                }
            }
        }
        switch weather {
        case "Overcast":
            return 0
        case "OvercastRain":
            return 0
        case "ThunderstormRain":
            return 0
        case "OvercastWetSnow":
            return 0
        case "OvercastSnow":
            return 0
        case "OvercastLightRain":
            return 0
        default:
            return 10
        }
    }
}
enum Season {
    case spring
    case summer
    case autumn
    case winter
}
