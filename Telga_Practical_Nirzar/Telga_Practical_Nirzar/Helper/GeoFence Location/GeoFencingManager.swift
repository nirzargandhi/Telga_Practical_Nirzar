//
//  GeoFencingManager.swift
//  UmpHire
//
//  Created by dharmesh on 23/08/18.
//  Copyright © 2018 Zaptech. All rights reserved.
//

class GeoFenceManager : NSObject {
    
    //MARK: - Variable Declaration
    static let sharedInstance : GeoFenceManager = {
        let instance = GeoFenceManager()
        return instance
    }()
    
    let objLocationManager = CLLocationManager()
    
    private override init() {
        super.init()
    }
    
    //MARK: - Check Location Permision Method
    func checkLocationPermision() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            
            case .notDetermined:
                getUserLocation()
                
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
                showLocationPermissionAlert(isNotAuthorizedAlways: true)
                
            case.authorizedAlways:
                print("authorizedAlways")
                objLocationManager.delegate = self
                objLocationManager.startUpdatingLocation()
                
            case .denied, .restricted:
                showLocationPermissionAlert()
                
            @unknown default:
                break
            }
        } else {
            getUserLocation()
        }
    }
    
    //MARK: - Get User Location Method
    func getUserLocation() {
        
        objLocationManager.delegate = self
        objLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        objLocationManager.requestAlwaysAuthorization()
        objLocationManager.requestWhenInUseAuthorization()
        
        objLocationManager.allowsBackgroundLocationUpdates = true
        objLocationManager.pausesLocationUpdatesAutomatically = false
        
        objLocationManager.startUpdatingLocation()
    }
    
    //MARK: - Show Location Permission Alert Method
    func showLocationPermissionAlert(isNotAuthorizedAlways : Bool = false) {
        let alertController = UIAlertController(title: isNotAuthorizedAlways ? "Always Authorize Location" : "Location Permission Required", message: isNotAuthorizedAlways ? "We require \"Always\" permission for fetching location in background mode" : "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Open Settings", style: .default, handler: {(cAlertAction) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        
        alertController.addAction(okAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Stop Location Method
    func stopLoaction() {
        objLocationManager.stopUpdatingLocation()
    }
    
    //MARK: - Start - Stop Monitoring Geo Fence Methods
    func startMonitoringGeoFence(radius: CLLocationDistance , location : CLLocationCoordinate2D , matchID: String , organizerID: String , dateOfMatch: TimeInterval) -> Bool {
        
        return true
    }
    
    func stopAllMonitoringGeoFence() {
        
    }
}

extension GeoFenceManager : CLLocationManagerDelegate {
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            
            case .notDetermined:
                getUserLocation()
                
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
                showLocationPermissionAlert(isNotAuthorizedAlways: true)
                
            case.authorizedAlways:
                print("authorizedAlways")
                objLocationManager.delegate = self
                objLocationManager.startUpdatingLocation()
                
            case .denied, .restricted:
                showLocationPermissionAlert()
                
            @unknown default:
                break
            }
        } else {
            getUserLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        objCurrentLocation = locValue
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered Region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited Region")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        switch state {
        
        case .inside:
            break
            
        case .outside:
            break
            
        default:
            break
        }
    }
}
