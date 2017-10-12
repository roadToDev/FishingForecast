import Foundation

struct ForecaWeatherForecast: Decodable {
    let pageViews: Int
    let email: String
    let tenDaysForecast: [ForecaDailyForecast]
    
    private enum CodingKeys : String, CodingKey {
        case pageViews = "hits"
        case email = "licensed_to"
        case tenDaysForecast = "fcd"
    }
}
