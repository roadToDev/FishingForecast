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
}
