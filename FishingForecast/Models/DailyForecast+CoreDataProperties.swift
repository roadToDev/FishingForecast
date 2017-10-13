import Foundation
import CoreData


extension DailyForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyForecast> {
        return NSFetchRequest<DailyForecast>(entityName: "DailyForecast")
    }

    @NSManaged public var cloudinessSymbolCode: String?
    @NSManaged public var date: String?
    @NSManaged public var maxTemperature: Int32
    @NSManaged public var minTemperature: Int32
    @NSManaged public var precipitationProbability: Int32
    @NSManaged public var pressure: Int32
    @NSManaged public var sunRise: String?
    @NSManaged public var sunSet: String?
    @NSManaged public var windDirection: String?
    @NSManaged public var windSpeed: Int32

}
