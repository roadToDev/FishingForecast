import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        animateTable()
        
       // ForecaApiManager.parse()
       // WaterTemperatureManager.waterTemperatureParse()
        //DataManager.clearData()
        
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        print (documentsPath)
        
//        let fetchRequest: NSFetchRequest<DailyForecast> = DailyForecast.fetchRequest()
//
//        do {
//            let tenDaysForecast = try DataManager.getContext().fetch(fetchRequest)
//
//            test.text = tenDaysForecast[0].date! + tenDaysForecast[1].date! + tenDaysForecast[2].date!
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colcell", for: indexPath) as! DatesCollectionViewCell
        
        cell.dateButton.setTitle(array[indexPath.row], for: .normal)
        
        let lastItemIndex = array.count - 1
        if indexPath.row == lastItemIndex {
            cell.lineImage.image = nil
        }
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbcell", for: indexPath)
        
        
        
        return cell
    }
    

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

