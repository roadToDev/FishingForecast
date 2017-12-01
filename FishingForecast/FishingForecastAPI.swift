import Foundation
import UIKit

struct FishingForecastAPI {
    
    let dataManager = DataManager()
    let imageManager = ImageManager()
    let dateManager = DateManager()
    let waterTemperatureManager = WaterTemperatureManager()
    let forecaApiManager = ForecaApiManager()
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
        
        switch hasConnection() {
        case true:
            if !dataManager.hasData(){
              //  dataManager.saveWeatherForecast(data: forecaApiManager.parse()!)
            } else {
                
            }
        case false:
            if dataManager.hasData(){
                return dataManager.loadDailyForecast()
            } else {
                return forecaApiManager.getParsedWeatherForecast()
            }
        }        
        
        
      //  if (hasData() && getFirstDayDate() != data[0].date) || !hasData() {
        
        
        
        
      //  forecaApiManager.parse()
        return dataManager.loadDailyForecast()
    }
    
    func format(fromDate: String) -> String{
        return dateManager.format(fromDate: fromDate)
    }
    
//    func saveToCoreData(){
//        forecaApiManager.parse()
//        if forecaApiManager.tenDays[0].date != dataManager.getFirstDayDate() {
//            dataManager.saveWeatherForecast(data: forecaApiManager.tenDays)
//        }
//    }
    
}
