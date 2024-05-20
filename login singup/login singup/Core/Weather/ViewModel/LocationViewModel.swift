//
//  LocationViewModel.swift
//  WeatherKitTest
//
//  Created by Dylan Corvo on 16/04/24.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject {
    private var locationManager: CLLocationManager
    @Published var location: CLLocation?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        //self.location = CLLocation(latitude: 37.42570722584336 , longitude: -121.89921160365728)
        stopUpdatingLocation()
    }
}
