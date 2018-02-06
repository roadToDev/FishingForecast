import Foundation

struct FishManager {
    
    func getFish() -> [Fish]? {
        var fish = [Fish]()

        if let fileURL = Bundle.main.url(forResource: "fish", withExtension: "json"){
            do {
                let data = try Data(contentsOf: fileURL)
                print(data)
                let jsonDecoder = JSONDecoder()
                let jsonDecodeResult = try! jsonDecoder.decode(FishJSON.self, from: data)
        
                fish = jsonDecodeResult.fish
            } catch {
                print ("No data")
            }
        } else {
            print("JSON file not found")
        }
        
        return fish
    }
    
    func getFishBy(type: Int, fish: [Fish]) -> [Fish]? {
        var typedFishArray = [Fish]()
        fish.forEach { item in
            if item.type == type {
                typedFishArray.append(item)
            }
        }
        if typedFishArray.count != 0 {
            return typedFishArray
        }
        return nil
    }
}
