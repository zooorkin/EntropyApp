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
    func sourceCoreMotionDidChangeRawValues(x: Double, y: Double, z: Double)
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
            self.timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                               block: { (timer) in
                                self.sendMotionData()
                                self.printMotionData()
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
        if motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0
            self.motion.startAccelerometerUpdates()
            
            // Configure a timer to fetch the motion data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                                            block: { (timer) in
                                                self.sendAccelerometerData()
                                                self.printAccelerometerData()
            })
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    func stopAccelerometer() {
        motion.stopAccelerometerUpdates()
        timer?.invalidate()
        timer = nil
    }
    
    func startGyroscope() {
        if motion.isGyroAvailable {
            self.motion.gyroUpdateInterval = 1.0 / 60.0
            self.motion.startGyroUpdates()
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                                   block: { (timer) in
                                    self.sendGyroscopeData()
                                    self.printGyroscopeData()
            })
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    
    func stopGyroscope() {
        motion.stopGyroUpdates()
        timer?.invalidate()
        timer = nil
    }
    
    func sendGyroscopeData() {
        if let data = self.motion.gyroData {
            let x = data.rotationRate.x
            let y = data.rotationRate.y
            let z = data.rotationRate.z
            delegate?.sourceCoreMotionDidChangeRawValues(x: x, y: y, z: z)
        }
    }
    
    func printGyroscopeData() {
        if let data = self.motion.gyroData {
            let x = data.rotationRate.x
            let y = data.rotationRate.y
            let z = data.rotationRate.z
            print("Gyroscope")
            print(".rotationRate.x: \(x)")
            print(".rotationRate.y: \(y)")
            print(".rotationRate.z: \(z)")
            print()
        }
    }

    func startMagnitometer() {
        if motion.isMagnetometerAvailable {
            self.motion.magnetometerUpdateInterval = 1.0 / 60.0
            self.motion.startMagnetometerUpdates()
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                                           block: { (timer) in
                                            self.sendMagnitometerData()
                                            self.printMagnitometerData()
            })
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    func stopMagnitometer() {
        motion.stopMagnetometerUpdates()
        timer?.invalidate()
        timer = nil
    }
    
    private func sendMagnitometerData() {
        if let data = self.motion.magnetometerData {
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            delegate?.sourceCoreMotionDidChangeRawValues(x: x, y: y, z: z)
        }
    }
    
    private func printMagnitometerData() {
        if let data = self.motion.magnetometerData {
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            print("Magnetometer")
            print(".magneticField.x: \(x)")
            print(".magneticField.y: \(y)")
            print(".magneticField.z: \(z)")
            print()
        }
    }
    
    private func sendAccelerometerData() {
        if let data = self.motion.accelerometerData {
            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            delegate?.sourceCoreMotionDidChangeRawValues(x: x, y: y, z: z)
        }
    }
    
    private func printAccelerometerData() {
        if let data = self.motion.accelerometerData {
            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            print("Accelerometer")
            print(".acceleration.x: \(x)")
            print(".acceleration.y: \(y)")
            print(".acceleration.z: \(z)")
            print()
        }
    }
    
    private func sendMotionData() {
        if let data = self.motion.deviceMotion {
            let x = data.attitude.roll
            let y = data.attitude.pitch
            let z = data.attitude.yaw
            delegate?.sourceCoreMotionDidChangeRawValues(roll: x, pitch: y, yaw: z)
        }
    }
    
    func printMotionData(){
        if let data = self.motion.deviceMotion {
            let x = data.attitude.roll
            let y = data.attitude.pitch
            let z = data.attitude.yaw
            print("Motion")
            print(".attitude.roll: \(x)")
            print(".attitude.pitch: \(y)")
            print(".attitude.yaw: \(z)")
            print()
        }
    }
    
    
}
