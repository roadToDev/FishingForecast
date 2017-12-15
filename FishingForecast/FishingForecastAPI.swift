import Foundation
import UIKit

struct FishingForecastAPI {
    
    let dataManager = DataManager()
    let imageManager = ImageManager()
    let dateManager = DateManager()
    let waterTemperatureManager = WaterTemperatureManager()
    var forecaApiManager = ForecaApiManager()
    let fishManager = FishManager()
  //  let biteLevelManager = BiteLevelManager(forecast: <#T##DailyForecast#>, fish: <#T##Fish#>)
    
    
    func getFish() -> [Fish]?{
        return fishManager.getFish()
    }
    
    func hasConnection() -> Bool {
        if Reachability.isConnectedToNetwork() {
            return true
        }
        return false
    }
    
    func showError() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showDataError()
    }
    
    func getDailyForecast() -> [WeatherForecast]? {
        return dataManager.loadDailyForecast()
    }
    
    func clearData() {
        dataManager.clear()
    }
    
    func saveData(data: [WeatherForecast]) {
        dataManager.save(data: data)
    }
    
    func parseDailyForecast(completion: @escaping ([WeatherForecast]) -> ()){
        forecaApiManager.parse { (success, response, error) in
            if success {
                var dailyForecast = [WeatherForecast]()
                guard let parsedData = response else { return }
                parsedData.forEach({ parameter in
                    
                    let dailyWeatherForecast = WeatherForecast(cloudinessSymbolCode: parameter.symbolCode, date: parameter.date, maxTemperature: Int32(parameter.maxTemperature), minTemperature: Int32(parameter.minTemperature), precipitationProbability: Int32(parameter.precipitationProbability), pressure: Int32((parameter.minPressure + parameter.maxPressure) / 2), sunRise: parameter.sunRise, sunSet: parameter.sunSet, windDirection: parameter.windDirection, windSpeed: Int32(parameter.windSpeed), moonPhase: Int32(parameter.moonPhase))
                    
                    dailyForecast.append(dailyWeatherForecast)
                })
                DispatchQueue.main.async {
                    completion(dailyForecast)
                }
            }
        }
    }
   
    func hasData() -> Bool {
        return dataManager.hasData()
    }
    
    func format(fromDate: String) -> String{
        return dateManager.format(fromDate: fromDate)
    }
}

