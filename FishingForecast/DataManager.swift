import Foundation
import CoreData

class DataManager {
    
    static func clearData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyForecast")
       
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try DataManager.getContext().execute(batchDeleteRequest)
        } catch {
            print (error)
        }
        
    }
    
    static func save (data: [ForecaDailyForecast]){
        show(data: data)
        data.forEach {parameter in
            
        let dailyForecast: DailyForecast = NSEntityDescription.insertNewObject(forEntityName: "DailyForecast", into: getContext()) as! DailyForecast
        
            dailyForecast.date = parameter.date
            dailyForecast.cloudinessSymbolCode = parameter.symbolCode
            dailyForecast.maxTemperature = Int32(parameter.maxTemperature)
            dailyForecast.minTemperature = Int32(parameter.minTemperature)
            dailyForecast.precipitationProbability = Int32(parameter.precipitationProbability)
            dailyForecast.pressure = Int32((parameter.maxPressure + parameter.minPressure) / 2)
            dailyForecast.sunRise = parameter.sunRise
            dailyForecast.sunSet = parameter.sunSet
            dailyForecast.windSpeed = Int32(parameter.windSpeed)
            dailyForecast.windDirection = parameter.windDirection
            dailyForecast.moonPhase = Int32(parameter.moonPhase)
            
        saveContext()
        }
        
    }
    
    static func show (data: [ForecaDailyForecast]) {
            
        data.forEach { parameter in
        
            print(String(parameter.date) + String(parameter.moonPhase))
            
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
