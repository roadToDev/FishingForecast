import Foundation
import CoreLocation

struct Constants {
    
    static let predatoryFishNumber = 2
    static let peacefullFishNumber = 1
    
    struct MainViewText {
        static let wind = "Ветер "
        static let pressure = "Давление "
        static let windDirection = [
            "N" : "Северный",
            "W" : "Западный",
            "S" : "Южный",
            "E" : "Восточный",
            "SE" : "Юго-восточный",
            "SW" : "Юго-западный",
            "NW" : "Северо-западный",
            "NE" : "Северо-восточный"            
        ]
        static let precipitationProbability = "Вероятность осадков "
        static let nightTemperature = "t° ночью "
        static let waterTemperature = "t° воды "
        static let noData = "нет данных"
        static let ms = " м/с"
        static let mm = " мм"
    }
    
    static let cities = ["Киев" : CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234),
                         "Белая Церковь" : CLLocationCoordinate2D(latitude: 49.7958, longitude: 30.1172),
                         "Березань" : CLLocationCoordinate2D(latitude: 50.3074, longitude: 31.4707)
                         ]
    
    static var citiesCoordinates : [CLLocationCoordinate2D] {
        var coordinates = [CLLocationCoordinate2D]()
        cities.forEach({ city in
            coordinates.append(city.value)
        })
        return coordinates
    }
    
//    struct MoonPhases {
//        static let newMoon =  "Новая луна"
//        static let waxingGrescent = "Молодая луна"
//        static let firstQuarter =  "Первая четверть"
//        static let waxingGibbous = "Прибывающая луна"
//        static let fullMoon = "Полная луна"
//        static let waningGibbous = "Убывающая луна"
//        static let lastQuarter =  "Последняя четверть"
//        static let waningGrescent =  "Старая луна"
//    }
    static let moonPhases = [
        0 ... 45 : "Новолуние",
        45 ... 90 : "Молодая луна",
        90 ... 135 : "Первая четверть",
        135 ... 180 : "Прибывающая луна",
        180 ... 225 : "Полная луна",
        225 ... 270 : "Убывающая луна",
        270 ... 315 : "Последняя четверть",
        315 ... 360 : "Старая луна"
    ]
}

extension CountableClosedRange : Hashable {
    public var hashValue: Int {
        return "\(lowerBound) to \(upperBound)".hashValue
    }
}

extension Dictionary where Key == CountableClosedRange<Int> {
    subscript(rawValue rawValue: Int) -> Value? {
        for key in self.keys {
            if key ~= rawValue {
                return self[key]
            }
        }
        return nil
    }
}
