import Foundation

class ForecaApiManager {
    
    func parse(_ urlString : String, completion: @escaping (Bool, [ForecaDailyForecast]?, Error?) -> ()){
        
        guard let url = URL(string: urlString) else {
            print("Error: \(urlString) not a valid URL")
            return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("Error: not a valid data")
                return }
            guard error == nil else {
                print("Error")
                return }
            do {
                    let parsedData = try JSONDecoder().decode(ForecaWeatherForecast.self, from: data)
                    let dailyForecast = parsedData.tenDaysForecast
                    DispatchQueue.main.async {
                       completion(true, dailyForecast, nil)
                    }
                } catch let error {
                    print (error)
                 //   completion(false, nil, error)
                }
        }.resume()
    }
    
//    func getParsedWeatherForecast() -> [WeatherForecast]?{
//        var tenDaysForecast = [WeatherForecast]()
//        var parsedData = [ForecaDailyForecast]()
//        parse { (success, response, error) in
//            if success {
//                guard let data = response as? [ForecaDailyForecast] else { return }
//                parsedData = data
//            }
//        }
//
//        parsedData.forEach { parameter in
//            print ("I'm here")
//            let forecast = WeatherForecast(cloudinessSymbolCode: parameter.symbolCode, date: parameter.date, maxTemperature: Int32(parameter.maxTemperature), minTemperature: Int32(parameter.minTemperature), precipitationProbability: Int32(parameter.precipitationProbability), pressure: Int32((parameter.maxPressure + parameter.minPressure) / 2), sunRise: parameter.sunRise, sunSet: parameter.sunSet, windDirection: parameter.windDirection, windSpeed: Int32(parameter.windSpeed), moonPhase: Int32(parameter.moonPhase))
//
//            tenDaysForecast.append(forecast)
//        }
//      //  print(tenDaysForecast[0])
//        return tenDaysForecast
//
//    }
}
