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
//                         "Богуслав" : CLLocationCoordinate2D(latitude: 49.5436, longitude: 30.8743),
//                         "Борисполь" : CLLocationCoordinate2D(latitude: 50.3600, longitude: 30.9544),
//                         "Боярка" : CLLocationCoordinate2D(latitude: 50.3256, longitude: 30.2925),
//                         "Бровары" : CLLocationCoordinate2D(latitude: 50.5068, longitude: 30.8046),
//                         "Буча" : CLLocationCoordinate2D(latitude: 50.5550, longitude: 30.2243),
//                         "Васильков" : CLLocationCoordinate2D(latitude: 50.1842, longitude: 30.3146),
//                         "Вишнёвое" : CLLocationCoordinate2D(latitude: 50.3881, longitude: 30.3710),
//                         "Вышгород" : CLLocationCoordinate2D(latitude: 50.5833, longitude: 30.5011),
//                         "Ирпень" : CLLocationCoordinate2D(latitude: 50.5238, longitude: 30.2407),
//                         "Кагарлык" : CLLocationCoordinate2D(latitude: 49.8569, longitude: 30.8208),
//                         "Мироновка" : CLLocationCoordinate2D(latitude: 49.6607, longitude: 30.9888),
//                         "Обухов" : CLLocationCoordinate2D(latitude: 50.1166, longitude: 30.6283),
//                         "Переяслав-Хмельницкий" : CLLocationCoordinate2D(latitude: 50.0728, longitude: 31.4525),
//                         "Припять" : CLLocationCoordinate2D(latitude: 51.4068, longitude: 30.0515),
//                         "Ржищев" : CLLocationCoordinate2D(latitude: 49.9684, longitude: 31.0491),
//                         "Сквира" : CLLocationCoordinate2D(latitude: 49.7319, longitude: 29.6639),
//                         "Славутич" : CLLocationCoordinate2D(latitude: 51.5216, longitude: 30.7234),
//                         "Тараща" : CLLocationCoordinate2D(latitude: 49.5607, longitude: 30.5015),
//                         "Тетиев" : CLLocationCoordinate2D(latitude: 49.3707, longitude: 29.6826),
//                         "Узин" : CLLocationCoordinate2D(latitude: 49.8279, longitude: 30.4246),
//                         "Украинка" : CLLocationCoordinate2D(latitude: 50.1407, longitude: 30.7388),
//                         "Фастов" : CLLocationCoordinate2D(latitude: 50.0793, longitude: 29.9066),
//                         "Чернобыль" : CLLocationCoordinate2D(latitude: 51.2735, longitude: 30.2254),
//                         "Яготин" : CLLocationCoordinate2D(latitude: 50.2622, longitude: 31.7816),
//                         "Бабинцы" : CLLocationCoordinate2D(latitude: 50.6382, longitude: 30.0215),
//                         "Барышевка" : CLLocationCoordinate2D(latitude: 50.3567, longitude: 31.3186),
//                         "Боровая" : CLLocationCoordinate2D(latitude: 50.1773, longitude: 30.1067),
//                         "Бородянка" : CLLocationCoordinate2D(latitude: 50.6466, longitude: 29.9226),
//                         "Великая Дымерка" : CLLocationCoordinate2D(latitude: 50.5932, longitude: 30.9081),
//                         "Володарка" : CLLocationCoordinate2D(latitude: 49.5271, longitude: 29.9171),
//                         "Ворзель" : CLLocationCoordinate2D(latitude: 50.5432, longitude: 30.1527),
//                         "Глеваха" : CLLocationCoordinate2D(latitude: 50.2654, longitude: 30.3040),
//                         "Гостомель" : CLLocationCoordinate2D(latitude: 50.5788, longitude: 30.2567),
//                         "Гребёнки" : CLLocationCoordinate2D(latitude: 49.9577, longitude: 30.1772),
//                         "Дослидницкое" : CLLocationCoordinate2D(latitude: 49.9226, longitude: 30.1484),
//                         "Дымер" : CLLocationCoordinate2D(latitude: 50.7776, longitude: 30.3034),
//                         "Згуровка" : CLLocationCoordinate2D(latitude: 50.4984, longitude: 31.7858),
//                         "Иванков" : CLLocationCoordinate2D(latitude: 50.3201, longitude: 31.0629),
//                         "Калиновка" : CLLocationCoordinate2D(latitude: 50.2263, longitude: 30.2323),
//                         "Калита" : CLLocationCoordinate2D(latitude: 50.7520, longitude: 31.0248),
//                         "Клавдиево-Тарасово" : CLLocationCoordinate2D(latitude: 50.5835, longitude: 30.0105),
//                         "Кодра" : CLLocationCoordinate2D(latitude: 50.5736, longitude: 29.5836),
//                         "Кожанка" : CLLocationCoordinate2D(latitude: 49.9706, longitude: 29.7639),
//                         "Козин" : CLLocationCoordinate2D(latitude: 50.2297, longitude: 30.6763),
//                         "Коцюбинское" : CLLocationCoordinate2D(latitude: 50.4894, longitude: 30.3345),
//                         "Красятичи" : CLLocationCoordinate2D(latitude: 51.0776, longitude: 29.6415),
//                         "Макаров" : CLLocationCoordinate2D(latitude: 50.4601, longitude: 29.8139),
//                         "Немешаево" : CLLocationCoordinate2D(latitude: 50.5664, longitude: 30.0948),
//                         "Песковка" : CLLocationCoordinate2D(latitude: 50.7007, longitude: 29.6000),
//                         "Ракитное" : CLLocationCoordinate2D(latitude: 49.6893, longitude: 30.4811),
//                         "Ставище" : CLLocationCoordinate2D(latitude: 49.3916, longitude: 30.1928),
//                         "Терезино" : CLLocationCoordinate2D(latitude: 49.8559, longitude: 30.1101),
//                         "Чабаны" : CLLocationCoordinate2D(latitude: 50.3400, longitude: 30.4221)
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
