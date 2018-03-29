import Foundation
import UIKit

struct FishingForecastAPI {
    
    let dataManager = DataManager()
    let imageManager = ImageManager()
    let dateManager = DateManager()
    let waterTemperatureManager = WaterTemperatureManager()
    let forecaApiManager = ForecaApiManager()
    let fishManager = FishManager()
    let biteLevelManager = BiteLevelManager()
    let nearestLocation = NearestLocation()
    
    func getNearestCityName() -> String? {
        return nearestLocation.getCityName()
    }
    func authorizationLocationStatus() -> Bool {
        return nearestLocation.authorizationLocationStatus()
    }
    
    func showWaterTemp(data: [WeatherForecast]){
       let array = waterTemperatureManager.getWaterTemperature(data: data)
        array?.forEach({ (element) in
            print(element)
        })
    }
    
    func calculateBitingLevel(_ fish: Fish, _ dateIndex: Int, _ forecast: [WeatherForecast]) -> Int {
        var month = 0
        if let date = dateManager.getDateBy(string: forecast[dateIndex].date) {
            month = dateManager.getMonthBy(date: date)
        }        
        return biteLevelManager.calculateLevel(fish, dateIndex, month, forecast)
    }
    
    func getBitingLevelImage(_ bitingLevel: Int) -> UIImage {
        return ImageManager.getImageByBitingLevel(bitingLevel)
    }
    
    func getMoonPhaseBy(degrees: Int32) -> String {
        var phase = ""
        Constants.moonPhases.forEach { moonPhase in
            if moonPhase.key ~= Int(degrees) {
                phase = moonPhase.value
            }
        }
        return phase
    }
    
    func getDateBy(string: String) -> String {
        return dateManager.getDayInWeekAndDateBy(string: string)
    }
    
    func convertToMmFrom(pascals: Int32) -> String {
        return String(Int(Double(pascals) * 0.75 - 15))
    }
    
    func getImageBy(symbolCode: String) -> UIImage {
        return ImageManager.getWeatherImageBy(symbolCode).image
    }
    
    func getWaterTemperature() {
    //    print(waterTemperatureManager.getWaterTemperature() ?? "Hello")
    }
    
    func getFish() -> [Fish]?{
        return fishManager.getFish()
    }
    func getFishBy(_ type: Int, from fish: [Fish]) -> [Fish]? {
        return fishManager.getFishBy(type: type, fish: fish)
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
    
    func loadDailyForecast() -> [WeatherForecast]? {
        return dataManager.loadDailyForecast()
    }    
    
    func saveData(data: [WeatherForecast], _ cityName: String) {
        dataManager.clear()
        dataManager.save(data: data, cityName)
    }
    
    func parseDailyForecast(_ urlString : String, completion: @escaping ([WeatherForecast]) -> ()){
        
        forecaApiManager.parse(urlString) { (success, response, error) in
            if success {
                //Need waterTemperatureParse here
                var dailyForecast = [WeatherForecast]()
                guard let parsedData = response else { return }
                parsedData.forEach({ parameter in
                    
                    let dailyWeatherForecast = WeatherForecast(cityName: "", cloudinessSymbolCode: parameter.symbolCode, date: parameter.date, maxTemperature: Int32(parameter.maxTemperature), minTemperature: Int32(parameter.minTemperature), precipitationProbability: Int32(parameter.precipitationProbability), pressure: Int32((parameter.minPressure + parameter.maxPressure) / 2), sunRise: parameter.sunRise, sunSet: parameter.sunSet, windDirection: parameter.windDirection, windSpeed: Int32(parameter.windSpeed), moonPhase: Int32(parameter.moonPhase), waterTemperature: 0)
                    
                    dailyForecast.append(dailyWeatherForecast)
                })
                let waterTemperatureArray = self.waterTemperatureManager.getWaterTemperature(data: dailyForecast)
                if let waterTemperatureArray = waterTemperatureArray {
                    for i in 0..<dailyForecast.count {
                        dailyForecast[i].waterTemperature = Int32(waterTemperatureArray[i])
                    }
                }                
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

