import Foundation
import CoreData

struct DataManager {
    
    let apiManager = ForecaApiManager()
    
    func clear() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyForecast")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try DataManager.getContext().execute(batchDeleteRequest)
        } catch {
            print (error)
        }
        
    }
    
    func hasData() -> Bool {
        guard let forecast = loadDailyForecast() else {
            return false
        }
        if forecast.count > 0 {
            return true
        } else {
            return false
        }        
    }
    
    func save(data: [WeatherForecast], _ cityName: String){
        
        data.forEach({ forecast in
            
            let dailyForecast: DailyForecast = NSEntityDescription.insertNewObject(forEntityName: "DailyForecast", into: DataManager.getContext()) as! DailyForecast
            
            dailyForecast.cityName = cityName
            dailyForecast.date = forecast.date
            dailyForecast.cloudinessSymbolCode = forecast.cloudinessSymbolCode
            dailyForecast.maxTemperature = Int32(forecast.maxTemperature)
            dailyForecast.minTemperature = Int32(forecast.minTemperature)
            dailyForecast.precipitationProbability = Int32(forecast.precipitationProbability)
            dailyForecast.pressure = forecast.pressure
            dailyForecast.sunRise = forecast.sunRise
            dailyForecast.sunSet = forecast.sunSet
            dailyForecast.windSpeed = Int32(forecast.windSpeed)
            dailyForecast.windDirection = forecast.windDirection
            dailyForecast.moonPhase = Int32(forecast.moonPhase)
            dailyForecast.waterTemperature = forecast.waterTemperature
            
            DataManager.saveContext()
        })
    }
    
    
    
    
    func loadDailyForecast() -> [WeatherForecast]? {
        
        var dailyForecast = [WeatherForecast]()
        let fetchRequest: NSFetchRequest<DailyForecast> = DailyForecast.fetchRequest()
        
        do {
            let fetchedData = try DataManager.getContext().fetch(fetchRequest)
            fetchedData.forEach{ parameter in
                let dailyWeatherForecast = WeatherForecast(cityName: parameter.cityName, cloudinessSymbolCode: parameter.cloudinessSymbolCode, date: parameter.date, maxTemperature: Int32(parameter.maxTemperature), minTemperature: Int32(parameter.minTemperature), precipitationProbability: Int32(parameter.precipitationProbability), pressure: parameter.pressure, sunRise: parameter.sunRise, sunSet: parameter.sunSet, windDirection: parameter.windDirection, windSpeed: Int32(parameter.windSpeed), moonPhase: Int32(parameter.moonPhase), waterTemperature: parameter.waterTemperature)
                
                dailyForecast.append(dailyWeatherForecast)
            }
        } catch {
            print (error)
        }
        return dailyForecast
    }
   
    
    // MARK: - Core Data stack
    
    static func getContext () -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FishingForecast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
