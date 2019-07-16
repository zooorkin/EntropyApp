//
//  SourceCoreLocation.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import CoreLocation

protocol ISourceCoreLocation {

    var delegate: ISourceCoreLocationDelegate? {get set}
    
    func startLocation()
    
    func stopLocation()
    
    func requestRandomNumbers(count: Int)
}


protocol ISourceCoreLocationDelegate {
    
    func sourceCoreLocationDidChangeRawValues(_ values: [Double])
}


class SourceCoreLocation: NSObject, ISourceCoreLocation, CLLocationManagerDelegate {
    

    var delegate: ISourceCoreLocationDelegate?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        
    }
    
    func startLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.distanceFilter = 0
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestRandomNumbers(count: Int) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            let location = locations[0]
            let x = location.coordinate.latitude
            let y = location.coordinate.longitude
            let z = location.altitude
            delegate?.sourceCoreLocationDidChangeRawValues([x, y, z])
            print("Core Location")
            print("Широта: \(location.coordinate.latitude)")
            print("Долгота: \(location.coordinate.longitude)")
            print("Высота над уровнем моря: \(location.altitude)")
            print("Пол здания: \(String(describing: location.floor))")
            print("Радиус горизонтальной точности: \(location.horizontalAccuracy) м")
            print("Радиус верикальной точности: \(location.verticalAccuracy) м")
            print()
        } else {
            print("location is Empty")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            startLocation()
        }
    }

}
