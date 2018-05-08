import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var popUp: UIView!    
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var autoCompleteStations = Constants.cities
    var autoComplete = [String]()
    let fishingForecastAPI = FishingForecastAPI()
    var autoSearchButtonTapped = false
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citySearchBar.returnKeyType = UIReturnKeyType.done
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.citySearchBar.delegate = self
        
        addAttributesToPopUp()
        addAttributesToSearchBar()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    func initCityName() -> String?{
        if let city = fishingForecastAPI.getNearestCityName() {
            cityName = city
            print (city)
            return city
        }
        return nil
    }
    
    
    @IBAction func closePopUp(_ sender: UIButton) {
        removeAnimate()
    }
    
    
    func cityLocationSearch() {
        if let city = initCityName() {
            cityName = city
            autoSearchButtonTapped = true
            performSegue(withIdentifier: "segue", sender: self)
            removeAnimate()
        } else {
            print ("No city Name")
        }
    }
    
    @IBAction func autoSearch(_ sender: UIButton) {
        cityLocationSearch()
    }
    
    @IBAction func search(_ sender: UIButton) {
        if checkCity() {
            performSegue(withIdentifier: "segue", sender: self)
            removeAnimate()
        }
    }
    
    func checkCity() -> Bool {
        guard let cityName = citySearchBar.text else {
            return false
        }
        var flag = false
        Constants.cities.forEach { city in
            if city.lowercased() == cityName.lowercased() {
                self.cityName = cityName
                flag = true                
            }
        }
        
        return flag
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ViewController
        viewController.cityName = cityName
        viewController.firstLaunch = false        
    }
    
    //MARK: Adding Attributes
    
    func addAttributesToPopUp() {
        self.popUp.layer.borderWidth = 1
        self.popUp.layer.cornerRadius = 9
        self.popUp.layer.borderColor = UIColor.lightGray.cgColor
    }
    func addAttributesToSearchBar() {
        self.citySearchBar.setSearchFieldBackgroundImage(UIImage(named: "search_bar.png"), for: .normal)
        self.citySearchBar.setImage(UIImage(named: "empty.png"), for: .search, state: .normal)
    }

    //MARK: PopUp animation
    
    private func showAnimate() {
        self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = self.view.transform.scaledBy(x: 0.7, y: 0.7)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished) {
                
                self.view.removeFromSuperview()
                
            }
            
        })
    }

}

    // MARK: - UITableView (For autocomplete)
extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as UITableViewCell
        
        cell.textLabel!.text = autoComplete[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        citySearchBar.text = selectedCell.textLabel!.text!
    }
}

    //MARK: - UISearchBar (autocomplete)
extension LocationViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var substring = (searchBar.text! as NSString).replacingCharacters(in: range, with: text)
        substring = substring.lowercased()
        searchForAutocomplete(substring: substring)
        
        return true
    }
    
    func searchForAutocomplete(substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        for key in autoCompleteStations {
            var myString: NSString! = key as NSString
            myString = myString.lowercased as NSString
            let substringRange: NSRange! = myString.range(of: substring)
            if substringRange.location == 0 {
                autoComplete.append(key)
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
