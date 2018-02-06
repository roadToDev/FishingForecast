import Foundation
import UIKit

struct ImageManager {
    
    static func getWeatherImageBy(_ symbolCode: String) -> (image: UIImage, description: String) {
        
        switch symbolCode {
        case "d000", "d100":
            return (#imageLiteral(resourceName: "Clear"), "Clear")
        case "d200", "d300", "d500":
            return (#imageLiteral(resourceName: "PartlyCloudy"), "PartlyCloudy")
        case "d400":
            return (#imageLiteral(resourceName: "Overcast"), "Overcast")
        case "d600":
            return (#imageLiteral(resourceName: "Fog"), "Fog")
        case "d210", "d310", "d220", "d320":
            return (#imageLiteral(resourceName: "LightRain"), "LightRain")
        case "d410":
            return (#imageLiteral(resourceName: "OvercastLightRain"), "OvercastLightRain")
        case "d420", "d430":
            return (#imageLiteral(resourceName: "OvercastRain"), "OvercastRain")
        case "d240", "d340":
            return (#imageLiteral(resourceName: "ShortThunderstorm"), "ShortThunderstorm")
        case "d440":
            return (#imageLiteral(resourceName: "ThunderstormRain"), "ThunderstormRain")
        case "d211", "d311", "d221":
            return (#imageLiteral(resourceName: "LightWetSnow"), "LightWetSnow")
        case "d411", "d321", "d421", "d431":
            return (#imageLiteral(resourceName: "OvercastWetSnow"), "OvercastWetSnow")
        case "d212", "d312", "d222", "d322":
            return (#imageLiteral(resourceName: "LightWetSnow"), "LightSnow")
        case "d412", "d422", "d432":
            return (#imageLiteral(resourceName: "OvercastSnow"), "OvercastSnow")
        default:
            return (#imageLiteral(resourceName: "Overcast"), "Overcast")
        }
        
    }
    
    static func getImageByBitingLevel(_ bitingLevel: Int) -> UIImage {
        
        switch bitingLevel {
        case 10:
            return #imageLiteral(resourceName: "lvl1")
        case 20:
            return #imageLiteral(resourceName: "lvl2")
        case 30:
            return #imageLiteral(resourceName: "lvl3")
        case 40:
            return #imageLiteral(resourceName: "lvl4")
        case 50:
            return #imageLiteral(resourceName: "lvl5")
        case 60:
            return #imageLiteral(resourceName: "lvl6")
        case 70:
            return #imageLiteral(resourceName: "lvl7")
        case 80:
            return #imageLiteral(resourceName: "lvl8")
        case 90:
            return #imageLiteral(resourceName: "lvl9")
        default:
            return #imageLiteral(resourceName: "lvl10")
        }
        
    }
    
}
