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
    
    
    
    @IBAction func showLocationPopUp(_ sender: UIButton) {
        let popOverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locationPopUp") as! LocationViewController
        
        self.addChildViewController(popOverViewController)
        popOverViewController.view.frame = self.view.frame
        self.view.addSubview(popOverViewController.view)
        popOverViewController.didMove(toParentViewController: self)
    }
    
    @IBAction func predatoryButtonTapped(_ sender: UIButton) {
        if fishType == Constants.peacefullFishNumber {
            fishType = Constants.predatoryFishNumber
            self.tableView.reloadData()
            animateTable()
        }
    }
    
    @IBAction func peacefullButtonTapped(_ sender: UIButton) {
        if fishType == Constants.predatoryFishNumber {
            fishType = Constants.peacefullFishNumber
            self.tableView.reloadData()
            animateTable()
        }
    }    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherForecast : [WeatherForecast]?
    var fish : [Fish]?
    var peacefullFish : [Fish]?
    var predatoryFish : [Fish]?
    var fishType = Constants.peacefullFishNumber
    var dateIndex = 0
    let fishingForecastAPI = FishingForecastAPI()
    let dataManager = DataManager()
    var firstLaunch = true
    var cityName = "Киев"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        cityButton.setTitle(cityName, for: .normal)
        getData()
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
    
    func initFish(){
        fish = fishingForecastAPI.getFish()
        if let fish = fish {
        peacefullFish = fishingForecastAPI.getFishBy(Constants.peacefullFishNumber, from: fish)
        predatoryFish = fishingForecastAPI.getFishBy(Constants.predatoryFishNumber, from: fish)
        }
    }
    
    func fetchData() {
        weatherForecast = fishingForecastAPI.loadDailyForecast()
    }
    func loadData() {
        if fishingForecastAPI.hasConnection() {
            let longtitude = Constants.geoLocations[cityName]!.longitude
            let latitude = Constants.geoLocations[cityName]!.latitude
            let urlString = "http://apitest.foreca.net/?lon=\(longtitude))&lat=\(latitude))&key=2FdEUT2SIA5oFJR1WTuVMWsC1c&format=json"
            fishingForecastAPI.parseDailyForecast(urlString, completion: { forecast in
                self.show(data: forecast, date: forecast[0].date)
                self.weatherForecast = forecast
                self.collectionView.reloadData()
                self.tableView.reloadData()
                self.fishingForecastAPI.clearData()
                self.fishingForecastAPI.saveData(data: forecast)
                self.fishingForecastAPI.showWaterTemp(data: forecast)
            })
        } else {
            fishingForecastAPI.showError()
        }
    }
    
    func getData() {
        initFish()
        if firstLaunch {
            if fishingForecastAPI.hasData() {
                fetchData()
                if let forecast = weatherForecast {
                    self.show(data: forecast, date: forecast[0].date)
                }
            } else {
                loadData()
            }
        } else {
            loadData()
        }
    }    
    
    func show(data: [WeatherForecast], date: String){
        
        data.forEach { forecast in
            if forecast.date == date {
                dateLabel.text = fishingForecastAPI.getDateBy(string: forecast.date)
                temperatureLabel.text = addPlusSignIfPlusTemperature(to: forecast.maxTemperature) + "°"
                nightTemperatureLabel.text = Constants.MainViewText.nightTemperature + addPlusSignIfPlusTemperature(to: forecast.minTemperature)
                if forecast.waterTemperature == 0 {
                    waterTemperatureLabel.text = Constants.MainViewText.noData
                } else {
                    waterTemperatureLabel.text = Constants.MainViewText.waterTemperature + "+" + String(forecast.waterTemperature)
                }
                sunRiseLabel.text = forecast.sunRise
                sunSetLabel.text = forecast.sunSet
                cloudnessImageView.image = fishingForecastAPI.getImageBy(symbolCode: forecast.cloudinessSymbolCode)
                windSpeedLabel.text = Constants.MainViewText.wind + String(forecast.windSpeed) + Constants.MainViewText.ms                
                windDirectionLabel.text = Constants.MainViewText.windDirection[forecast.windDirection]
                pressureLabel.text = Constants.MainViewText.pressure + fishingForecastAPI.convertToMmFrom(pascals: forecast.pressure)  + Constants.MainViewText.mm
                precipitationProbabilityLabel.text = Constants.MainViewText.precipitationProbability + String(forecast.precipitationProbability) + "%"
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
    
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(weatherForecast?.count ?? 0)
        return weatherForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colcell", for: indexPath) as! DatesCollectionViewCell
        
        let forecast = weatherForecast
        cell.dateButton.setTitle(fishingForecastAPI.format(fromDate: forecast![indexPath.row].date) , for: .normal)
        
        let lastItemIndex = (weatherForecast?.count)! - 1
        if indexPath.row == lastItemIndex {
            cell.lineImage.image = nil
        }
        cell.dateButton.addTarget(self, action: #selector(masterCellAction), for: .touchUpInside )
        
        
        return cell
    }
    
    @IBAction func masterCellAction(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.collectionView)
        
        let indexPath = self.collectionView.indexPathForItem(at: buttonPosition)
        
        if let dailyForecast = weatherForecast {
            let selectedCellDate = dailyForecast[(indexPath?.row)!].date
            show(data: dailyForecast, date: selectedCellDate)
            dateIndex = indexPath?.row ?? 0
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fishType == Constants.peacefullFishNumber {
            return peacefullFish?.count ?? 0
        } else {
            return predatoryFish?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbcell", for: indexPath) as! FishAndBiteLevelTableViewCell
        
        var bitingLevel = 10
        if peacefullFish != nil && predatoryFish != nil && weatherForecast != nil {
            if fishType == Constants.peacefullFishNumber {
                cell.fishImage.image = UIImage(named: (peacefullFish![indexPath.row].name + ".png"))
                bitingLevel = fishingForecastAPI.calculateBitingLevel(peacefullFish![indexPath.row], dateIndex, weatherForecast!)
                cell.biteLevelImage.image = fishingForecastAPI.getBitingLevelImage(bitingLevel)
            } else {
                cell.fishImage.image = UIImage(named: (predatoryFish![indexPath.row].name + ".png"))
                bitingLevel = fishingForecastAPI.calculateBitingLevel(predatoryFish![indexPath.row], dateIndex, weatherForecast!)
                cell.biteLevelImage.image = fishingForecastAPI.getBitingLevelImage(bitingLevel)
            }
        }        
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

