import Foundation

struct ForecaApiManager {
     
    func parse() -> [ForecaDailyForecast]? {
        
        var dailyForecast = [ForecaDailyForecast]()
       
        let urlString = "http://apitest.foreca.net/?lon=30.52&lat=50.43&key=2FdEUT2SIA5oFJR1WTuVMWsC1c&format=json"
        guard let url = URL(string: urlString) else {
            print("Error: \(urlString) not a valid URL")
            return nil }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("Error: not a valid data")
                return }
            guard error == nil else {
                print("Error")
                return }
            do {
                let parsedData = try JSONDecoder().decode(ForecaWeatherForecast.self, from: data)
                dailyForecast = parsedData.tenDaysForecast
                } catch let error {
                    print (error)
                }
            
        }.resume()
        return dailyForecast
    }
    
    func getParsedWeatherForecast() -> [WeatherForecast]{
        var tenDaysForecast = [WeatherForecast]()
        let parsedData = parse()
        
        parsedData!.forEach { parameter in
            
            let forecast = WeatherForecast(cloudinessSymbolCode: parameter.symbolCode, date: parameter.date, maxTemperature: Int32(parameter.maxTemperature), minTemperature: Int32(parameter.minTemperature), precipitationProbability: Int32(parameter.precipitationProbability), pressure: Int32((parameter.maxPressure + parameter.minPressure) / 2), sunRise: parameter.sunRise, sunSet: parameter.sunSet, windDirection: parameter.windDirection, windSpeed: Int32(parameter.windSpeed), moonPhase: Int32(parameter.moonPhase))
            
            tenDaysForecast.append(forecast)
        }
        return tenDaysForecast
    }
    
}
