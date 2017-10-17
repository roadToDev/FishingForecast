import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForecaApiManager.parse()
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


}

