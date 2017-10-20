import Foundation
import SwiftSoup

struct WaterTemperatureManager {
    
    static var waterTemperature = ""
    
    static func waterTemperatureParse() {
        
        var html = ""
        
            let myURLString = "https://www.gismeteo.ua/weather-kyiv-4944/"
            guard let myURL = URL(string: myURLString) else {
                print("Error: \(myURLString) not valid URL")
                return
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
                            getWaterTemperature(text)
                        }
                    }
                }
            } catch {
                print (error)
            }
    }
    
    private static func getWaterTemperature(_ string : String) {
            if let endIndex = string.range(of: "°")?.lowerBound {
                waterTemperature = String(string[..<endIndex])
            } else { return }
    }
    
}
