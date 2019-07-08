//
//  SourceCoreMotion.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceCoreMotion {

    var delegate: ISourceCoreMotionDelegate? {get set}
    
    func startMotion()
    
    func stopMotion()
    
    func startAccelerometer()
    
    func stopAccelerometer()
    
    func startGyroscope()
    
    func stopGyroscope()
    
    func startMagnitometer()
    
    func stopMagnitometer()
    
}


protocol ISourceCoreMotionDelegate: class {
    func sourceCoreMotionDidChangeRawValues(roll: Double, pitch: Double, yaw: Double)
    func sourceCoreMotionDidGetRandomNumber(_ value: UInt32)
}

import CoreMotion

class SourceCoreMotion: ISourceCoreMotion {

    weak var delegate: ISourceCoreMotionDelegate?

    private let motion: CMMotionManager
    private var timer: Timer?
    
    init() {
        motion = CMMotionManager()
    }
    
    func startMotion() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates()
//            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            self.timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                               block: { (timer) in
                                self.sendData()
                                self.printMotion()
            })
            
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    func stopMotion() {
        motion.stopDeviceMotionUpdates()
        timer?.invalidate()
        timer = nil
    }

    
    func startAccelerometer() {
        
    }
    
    func stopAccelerometer() {
        
    }
    
    func startGyroscope() {
        
    }
    
    func stopGyroscope() {
        
    }

    func startMagnitometer() {
        
    }
    
    func stopMagnitometer() {
        
    }
    
    private func sendData(){
        if let data = self.motion.deviceMotion {
            let x = data.attitude.roll
            let y = data.attitude.pitch
            let z = data.attitude.yaw
            delegate?.sourceCoreMotionDidChangeRawValues(roll: x, pitch: y, yaw: z)
        }
    }
    
    func printMotion(){
        if let data = self.motion.deviceMotion {
            let x = data.attitude.roll
            let y = data.attitude.pitch
            let z = data.attitude.yaw
            print("Motion")
            print(".attitude.roll: \(x / 3.14 * 360)")
            print(".attitude.pitch: \(y / 3.14 * 360)")
            print(".attitude.yaw: \(z / 3.14 * 360)")
            print()
        }
    }
    
    
}
