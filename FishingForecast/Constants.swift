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
    
    static let geoLocations = ["Киев" : CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234),
                         "Белая Церковь" : CLLocationCoordinate2D(latitude: 49.7958, longitude: 30.1172),
                         "Березань" : CLLocationCoordinate2D(latitude: 50.3074, longitude: 31.4707)
//                         "Богуслав" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Борисполь" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Боярка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Бровары" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Буча" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Васильков" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Вишнёвое" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Вышгород" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Ирпень" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Кагарлык" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Мироновка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Обухов" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Переяслав-Хмельницкий" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Припять" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Ржищев" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Сквира" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Славутич" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Тараща" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Тетиев" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Узин" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Украинка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Фастов" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Чернобыль" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Яготин" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Бабинцы" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Барышевка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Боровая" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Бородянка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Великая Дымерка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Володарка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Ворзель" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Глеваха" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Гостомель" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Гребёнки" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Дослидницкое" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Дымер" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Згуровка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Иванков" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Калиновка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Калита" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Клавдиево-Тарасово" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Кодра" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Кожанка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Козин" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Коцюбинское" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Красятичи" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Макаров" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Немешаево" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Песковка" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Ракитное" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Ставище" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Терезино" : CLLocationCoordinate2D(latitude: 0, longitude: 0),
//                         "Чабаны" : CLLocationCoordinate2D(latitude: 0, longitude: 0)
                         ]
    
    static var cities : [String] {
        var cities = [String]()
        geoLocations.forEach { location in
            cities.append(location.key)
        }
        return cities
    }
    
    static var citiesCoordinates : [CLLocationCoordinate2D] {
        var coordinates = [CLLocationCoordinate2D]()
        geoLocations.forEach({ city in
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
