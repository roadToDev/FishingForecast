import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let fishingForecastAPI = FishingForecastAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        
        animateTable()
        
     //   fishingForecastAPI.showForecaApiParsed()
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
        
     //   let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    //    print (documentsPath)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let array = ["21.09", "22.09", "23.09", "24.09", "25.09", "26.09", "27.09", "28.09", "29.09", "30.09"]
    
        
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let forecast = fishingForecastAPI.getDailyForecast()!
        print(forecast.count)
        return (forecast.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colcell", for: indexPath) as! DatesCollectionViewCell
        let forecast = fishingForecastAPI.getDailyForecast()!
        cell.dateButton.setTitle(fishingForecastAPI.format(fromDate: forecast[indexPath.row].date!) , for: .normal)
        
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

