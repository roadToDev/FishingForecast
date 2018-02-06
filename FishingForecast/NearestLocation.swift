import CoreLocation

class NearestLocation : NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var citiesCoordinates = Constants.citiesCoordinates
    
    func authorizationLocationStatus() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            return true
        } else {
            return false
        }
    }
    
    func getCityName() -> String? {        
        guard let location = get() else { return nil }
        let coordinates : CLLocationCoordinate2D = location.coordinate
        
        var cityName = ""
        Constants.cities.forEach { location in
            if location.value.latitude == coordinates.latitude && location.value.longitude == coordinates.longitude {
                cityName = location.key
            }
        }
        if cityName != "" {
            return cityName
        }
        return nil
    }
    
    func get () -> CLLocation? {
        let userLocation = findUserLocation()
        
        if let pointToCompare = userLocation {
            let sortedCoordinates = citiesCoordinates.map({CLLocation(latitude: $0.latitude, longitude: $0.longitude)}).sorted(by: {
                $0.distance(from: pointToCompare) < $1.distance(from: pointToCompare)
            })
            return sortedCoordinates.first
        }
        return nil
    }
    
    private func findUserLocation() -> CLLocation? {
        
        manager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse){
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyKilometer
            manager.startUpdatingLocation()
        
            if let currentLocation = manager.location {
                print(currentLocation)
                return currentLocation

            } else {
                return nil
                
            }
           
//            if (currentLocation?.timestamp)! <= Date() {
//                print(currentLocation?.timestamp)
//                print(Date())
//                manager.startUpdatingLocation()
//                currentLocation = manager.location
//            }
          //  return currentLocation
        }
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        print(manager.location)
    }
    
}
