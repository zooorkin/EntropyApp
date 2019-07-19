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
    
    func startAltimeter()
    
    func stopAltimeter()
    
    func requestRandomNumbers(count: Int)
}


protocol ISourceCoreLocationDelegate {
    
    func sourceCoreLocationDidChangeRawValues(_ values: [Double], source: SourceLocation)
    
    func sourceCoreLocationDidGetRandomNumbers(_ numbers: [UInt32], source: SourceLocation)
    
    func sourceCoreLocationDidCountRandomNumbers(_ count: Int, source: SourceLocation)
    
}

enum SourceLocation {
    case Location
    case Altimeter
}

class SourceCoreLocation: NSObject, ISourceCoreLocation, CLLocationManagerDelegate {

    var delegate: ISourceCoreLocationDelegate?
    
    private let locationManager: CLLocationManager
    
    private var sourceState: SourceLocation?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        
    }
    
    func startLocation() {
        sourceState = .Location
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.distanceFilter = 0
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocation() {
        sourceState = nil
        locationManager.stopUpdatingLocation()
    }
    
    func startAltimeter() {
        sourceState = .Altimeter
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.distanceFilter = 0
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopAltimeter() {
        sourceState = nil
        locationManager.stopUpdatingLocation()
    }
    
    var randomNumbers: [UInt32] = []
    var requiredCountOfRandomNumbers: Int?
    
    func requestRandomNumbers(count: Int) {
        requiredCountOfRandomNumbers = count
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            //let countOfLocations = locations.count
            let location = locations[0]
            let x = location.coordinate.latitude
            let y = location.coordinate.longitude
            let z = location.altitude
            
            switch sourceState! {
            case SourceLocation.Location:
                delegate?.sourceCoreLocationDidChangeRawValues([x, y], source: .Location)
            case SourceLocation.Altimeter:
                delegate?.sourceCoreLocationDidChangeRawValues([z], source: .Altimeter)
            }
            
            if let requiredCount = requiredCountOfRandomNumbers {
                switch sourceState! {
                    case SourceLocation.Location:
                        randomNumbers += [UInt32(x.getLast32()), UInt32(y.getLast32())]
                    case SourceLocation.Altimeter:
                        randomNumbers += [UInt32(z.getFirst32())]
                }
                delegate?.sourceCoreLocationDidCountRandomNumbers(randomNumbers.count, source: sourceState!)
                if randomNumbers.count >= requiredCount {
                    while randomNumbers.count > requiredCount {
                        randomNumbers.remove(at: randomNumbers.count - 1)
                    }
                    delegate?.sourceCoreLocationDidGetRandomNumbers(randomNumbers, source: sourceState!)
                    delegate?.sourceCoreLocationDidCountRandomNumbers(randomNumbers.count, source: sourceState!)
                    requiredCountOfRandomNumbers = nil
                    randomNumbers = []
                }
            }
            
//            print("Core Location")
//            print("Число локаций: \(countOfLocations)")
//            print("Широта: \(location.coordinate.latitude)")
//            print("Долгота: \(location.coordinate.longitude)")
//            print("Высота над уровнем моря: \(location.altitude)")
//            print("Пол здания: \(String(describing: location.floor))")
//            print("Радиус горизонтальной точности: \(location.horizontalAccuracy) м")
//            print("Радиус верикальной точности: \(location.verticalAccuracy) м")
//            print()
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
