import Foundation

class ForecaApiManager {
    
    static var tenDays = [ForecaDailyForecast]()
 
    static func parse() {
       
        let urlString = "http://apitest.foreca.net/?lon=30.52&lat=50.43&key=2FdEUT2SIA5oFJR1WTuVMWsC1c&format=json"
        guard let url = URL(string: urlString) else {
            print("Error: \(urlString) not a valid URL")
            return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("Error: not a valid data")
                return }
            guard error == nil else {
                print("Error")
                return }
            do {
                let parsedData = try JSONDecoder().decode(ForecaWeatherForecast.self, from: data)
                DataManager.save(data: parsedData.tenDaysForecast)
                tenDays = parsedData.tenDaysForecast
                } catch let error {
                    print (error)
                }
            
        }.resume()
    }
}
