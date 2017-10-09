import Foundation

struct ForecaWeatherForecast: Decodable {
    let pageViews: Int
    let email: String
    let nineDaysForecast: [ForecaDailyForecast]
    
    private enum CodingKeys : String, CodingKey {
        case pageViews = "hits"
        case email = "licensed_to"
        case nineDaysForecast = "fcd"
    }
}
