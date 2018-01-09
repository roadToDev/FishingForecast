import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var nightTemperatureLabel: UILabel!
    
    @IBOutlet weak var waterTemperatureLabel: UILabel!
    
    @IBOutlet weak var sunRiseLabel: UILabel!
    
    @IBOutlet weak var sunSetLabel: UILabel!
    
    @IBOutlet weak var cloudnessImageView: UIImageView!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var precipitationProbabilityLabel: UILabel!
    
    @IBOutlet weak var moonPhaseLabel: UILabel!
    
    
    
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var dailyForecast : [WeatherForecast]?
    
    let fishingForecastAPI = FishingForecastAPI()
    let dataManager = DataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        fetchData()
        animateTable()
       // ForecaApiManager.parse()
        
      //////  dataManager.saveWeatherForecast()
     //   fishingForecastAPI.showForecaApiParsed()
        //fishingForecastAPI.getWaterTemperature()
        print(fishingForecastAPI.hasConnection())
      //  fishingForecastAPI.test()
        
     //   ForecaAPIManager.parse()
      //  DataManager.saveWeatherForecast(data: ForecaAPIManager.tenDays)
        
//        FishDataManager.getFish()?.forEach{ fish in
//            print(fish.name)
//            }
        
    //    ForecaAPIManager.parse()
     //   DataManager.show(data: ForecaAPIManager.tenDays)
        
       // WaterTemperatureManager.waterTemperatureParse()
        //DataManager.clearData()
        
//let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//print (documentsPath)
        
//        let fetchRequest: NSFetchRequest<DailyForecast> = DailyForecast.fetchRequest()
//
//        do {
//            let tenDaysForecast = try DataManager.getContext().fetch(fetchRequest)
//
//            print(tenDaysForecast[0].date! + tenDaysForecast[1].date! + tenDaysForecast[2].date!)
//
//        } catch {
//            print (error)
//        }
        
    }

    func fetchData(){
        
        switch fishingForecastAPI.hasConnection() {
        case true:
            fishingForecastAPI.parseDailyForecast(completion: { forecast in
                self.show(data: forecast, date: forecast[0].date!)
                self.dailyForecast = forecast
                self.collectionView.reloadData()
                self.fishingForecastAPI.clearData()
                self.fishingForecastAPI.saveData(data: forecast)
                self.fishingForecastAPI.showWaterTemp(data: forecast)
            })
            
        case false:
            if fishingForecastAPI.hasData() {
                dailyForecast = fishingForecastAPI.loadDailyForecast()
            } else {
                fishingForecastAPI.showError()
            }
        }
    }
    
    func show(data: [WeatherForecast], date: String){
        
        data.forEach { forecast in
            if forecast.date == date {
                cityButton.titleLabel?.text = "Киев"
                dateLabel.text = forecast.date
                temperatureLabel.text = addPlusSignIfPlusTemperature(to: forecast.maxTemperature)
                nightTemperatureLabel.text = Constants.MainViewText.nightTemperature + addPlusSignIfPlusTemperature(to: forecast.minTemperature)
                waterTemperatureLabel.text = Constants.MainViewText.waterTemperature + String(3)
                sunRiseLabel.text = forecast.sunRise
                sunSetLabel.text = forecast.sunSet
                cloudnessImageView.image = fishingForecastAPI.getImageBy(symbolCode: forecast.cloudinessSymbolCode!)
                windSpeedLabel.text = Constants.MainViewText.wind + String(forecast.windSpeed) + Constants.MainViewText.ms
                windDirectionLabel.text = Constants.MainViewText.windDirection[forecast.windDirection!]
                pressureLabel.text = Constants.MainViewText.pressure + fishingForecastAPI.convertToMmFrom(pascals: forecast.pressure)  + Constants.MainViewText.mm
                precipitationProbabilityLabel.text = Constants.MainViewText.precipitationProbability + String(forecast.precipitationProbability) + " %"
                moonPhaseLabel.text = fishingForecastAPI.getMoonPhaseBy(degrees: forecast.moonPhase)
            }
        }
        
    }
    func addPlusSignIfPlusTemperature(to temperature: Int32) -> String {
        if temperature > 0 {
            return "+\(temperature)"
        }
        return String(temperature)
    }
    
    let array = ["21.09", "22.09", "23.09", "24.09", "25.09", "26.09", "27.09", "28.09", "29.09", "30.09"]
    
        
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dailyForecast?.count)
        return dailyForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colcell", for: indexPath) as! DatesCollectionViewCell
        
        let forecast = dailyForecast
        cell.dateButton.setTitle(fishingForecastAPI.format(fromDate: forecast![indexPath.row].date!) , for: .normal)
        
        let lastItemIndex = array.count - 1
        if indexPath.row == lastItemIndex {
            cell.lineImage.image = nil
        }
     
        
        return cell
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbcell", for: indexPath)
        
        
        
        return cell
    }
    
    // MARK: - Animation
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells

        let tableViewHeight = tableView.bounds.size.height

        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }

        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }

    }
}

