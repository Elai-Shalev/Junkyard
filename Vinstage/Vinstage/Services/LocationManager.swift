import Combine
import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var lastLocation: Location?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.pausesLocationUpdatesAutomatically = true
        if locationManager.authorizationStatus == .authorizedWhenInUse{
//            locationManager.startUpdatingLocation()

        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            authorizationStatus = .authorizedWhenInUse
//            locationManager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized

            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break

        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break

        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break

        case .notDetermined:  // Authorization not determined yet.
            authorizationStatus = .notDetermined
            break

        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = Location(clLocation: location)
//        stopLocationUpdates()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard error is CLError else {
            return
        }
        print("error: \(error.localizedDescription)")
    }

    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    func requestAuth() {
        locationManager.requestWhenInUseAuthorization()
    }

}
