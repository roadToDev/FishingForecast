import Foundation
import SwiftSoup

struct WaterTemperatureManager {
    
    func parseWaterTemperature() -> String? {
        
        var html = ""
        
        let myURLString = "https://www.gismeteo.ua/weather-kyiv-4944/"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) not valid URL")
            return nil
        }
        do {
            html = try String(contentsOf: myURL, encoding: .utf8)
        } catch {
            print (error)
        }        
        
        do {
            let doc = try SwiftSoup.parse(html)
            do {
                let elements = try doc.getElementsByClass("wicon water")
                do {
                    for elem in elements {
                        let text = try elem.text()
                        return text
                    }
                }
            }
        } catch {
            print (error)
        }
        return nil
    }
    
    func getWaterTemperature(data: [WeatherForecast]) -> [Int]?{
        var firstDayWaterTemperature : String?
        if let string = parseWaterTemperature(){
            if let endIndex = string.range(of: "°")?.lowerBound {
                firstDayWaterTemperature = String(string[..<endIndex])
            }
        }
        if firstDayWaterTemperature != nil {
            let waterTemperatureArray = calculateWaterTemperature(data: data, firstDayWaterTemperature!)
            return waterTemperatureArray
        }
        return nil
    }
    
    func calculateWaterTemperature(data: [WeatherForecast], _ firstDayWaterTemperature: String) -> [Int] {
        var waterTemperature = [Int]()
        let minWaterTemperature = 3
        
        data.forEach { dailyTemperature in
            if waterTemperature.count == 0 {
                waterTemperature.append(Int(firstDayWaterTemperature)!)
            } else {
                let lastElement = waterTemperature[waterTemperature.count - 1]                
                if (Int(dailyTemperature.maxTemperature) - lastElement) >= 5 {
                    waterTemperature.append(lastElement + 1)
                } else if (Int(dailyTemperature.maxTemperature) - lastElement) >= 2  {
                    waterTemperature.append(lastElement)
                } else {
                    if (lastElement - 1) < minWaterTemperature {
                        waterTemperature.append(minWaterTemperature)
                    } else {
                        waterTemperature.append(lastElement - 1)
                    }
                }
            }
        }
        return waterTemperature
    }
}
