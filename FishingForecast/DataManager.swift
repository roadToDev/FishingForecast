import Foundation
import CoreData

struct DataManager {
    
    func clearData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyForecast")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try DataManager.getContext().execute(batchDeleteRequest)
        } catch {
            print (error)
        }
        
    }
    
    func hasData() -> Bool {
        let data = loadDailyForecast()
        if data.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func getFirstDayDate() -> String? {
        if hasData() {
            return loadDailyForecast()[0].date
        }
        return nil
    }
    
    func saveWeatherForecast (data: [WeatherForecast]){
        
        data.forEach { parameter in

                let dailyForecast: DailyForecast = NSEntityDescription.insertNewObject(forEntityName: "DailyForecast", into: DataManager.getContext()) as! DailyForecast

                dailyForecast.date = parameter.date
                dailyForecast.cloudinessSymbolCode = parameter.cloudinessSymbolCode
                dailyForecast.maxTemperature = Int32(parameter.maxTemperature)
                dailyForecast.minTemperature = Int32(parameter.minTemperature)
                dailyForecast.precipitationProbability = Int32(parameter.precipitationProbability)
                dailyForecast.pressure = parameter.pressure
                dailyForecast.sunRise = parameter.sunRise
                dailyForecast.sunSet = parameter.sunSet
                dailyForecast.windSpeed = Int32(parameter.windSpeed)
                dailyForecast.windDirection = parameter.windDirection
                dailyForecast.moonPhase = Int32(parameter.moonPhase)

                DataManager.saveContext()
            }
    }
    
    func loadDailyForecast() -> [WeatherForecast] {
        var tenDaysForecast = [WeatherForecast]()
        let fetchedData : [DailyForecast]
        let fetchRequest: NSFetchRequest<DailyForecast> = DailyForecast.fetchRequest()
        
        do {
            fetchedData = try DataManager.getContext().fetch(fetchRequest)
            fetchedData.forEach{ parameter in
            let dailyWeatherForecast = WeatherForecast(cloudinessSymbolCode: parameter.cloudinessSymbolCode, date: parameter.date, maxTemperature: Int32(parameter.maxTemperature), minTemperature: Int32(parameter.minTemperature), precipitationProbability: Int32(parameter.precipitationProbability), pressure: parameter.pressure, sunRise: parameter.sunRise, sunSet: parameter.sunSet, windDirection: parameter.windDirection, windSpeed: Int32(parameter.windSpeed), moonPhase: Int32(parameter.moonPhase))
                tenDaysForecast.append(dailyWeatherForecast)
            }
        } catch {
            print (error)
        }
        return tenDaysForecast
    }
    
    private func fetchData() -> [DailyForecast]{
        
        let fetchRequest: NSFetchRequest<DailyForecast> = DailyForecast.fetchRequest()
        
        do {
            let tenDaysForecast = try DataManager.getContext().fetch(fetchRequest)
            
            return tenDaysForecast
        } catch {
            print (error)
        }
        return []
        
    }
    
    static func show (data: [ForecaDailyForecast]) {
        
        data.forEach { parameter in
            
            print("date: " + String(parameter.date))
            print("cloudinessSymbolCode: " + parameter.symbolCode)
            print("maxTemperature: " + String(parameter.maxTemperature))
            print("minTemperature: " + String(parameter.minTemperature))
            print("precipitationProbability: " + String(parameter.precipitationProbability))
            print("pressure: " + String((parameter.maxPressure + parameter.minPressure) / 2))
            print("sunRise: " + String(parameter.sunRise))
            print("sunSet: " + String(parameter.sunSet))
            print("windSpeed: " + String(parameter.windSpeed))
            print("windDirection: " + String(parameter.windDirection))
            print("moonPhase: " + String(parameter.moonPhase))
            
        }
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
