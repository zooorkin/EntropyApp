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
    
    func requestRandomNumbersFromMotion(count: Int)
    
    func requestRandomNumbersFromAccelerometer(count: Int)
    
    func requestRandomNumbersFromGyroscope(count: Int)
    
    func requestRandomNumbersFromMagnitometer(count: Int)
    
    func startAccelerometer()
    
    func stopAccelerometer()
    
    func startGyroscope()
    
    func stopGyroscope()
    
    func startMagnitometer()
    
    func stopMagnitometer()
    
}


protocol ISourceCoreMotionDelegate: class {
    func sourceCoreMotionDidChangeRawValues(_ values: [Double], source: SourceMotion)
    func sourceCoreMotionDidGetRandomNumbers(_ numbers: [UInt32], source: SourceMotion)
    func sourceCoreMotionDidGetRandomNumbers(_ numbers: [UInt16], source: SourceMotion)
    func sourceCoreMotionDidCountRandomNumbers(_ count: Int, source: SourceMotion)
}

import CoreMotion

enum SourceMotion {
    case Accelerometer
    case Gyroscope
    case Magnitometer
    case Motion
}

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
            })
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    
    func stopGyroscope() {
        motion.stopGyroUpdates()
        timer?.invalidate()
        timer = nil
    }
    
    func startMagnitometer() {
        if motion.isMagnetometerAvailable {
            self.motion.magnetometerUpdateInterval = 1.0 / 60.0
            self.motion.startMagnetometerUpdates()
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                               block: { (timer) in
                                self.sendMagnitometerData()
            })
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    func stopMagnitometer() {
        motion.stopMagnetometerUpdates()
        timer?.invalidate()
        timer = nil
    }
    
    func sendGyroscopeData() {
        if let data = self.motion.gyroData {
            let x = data.rotationRate.x
            let y = data.rotationRate.y
            let z = data.rotationRate.z
            delegate?.sourceCoreMotionDidChangeRawValues([x, y, z], source: .Gyroscope)
        }
    }
    
    private func sendMagnitometerData() {
        if let data = self.motion.magnetometerData {
            let x = data.magneticField.x
            let y = data.magneticField.y
            let z = data.magneticField.z
            delegate?.sourceCoreMotionDidChangeRawValues([x, y, z], source: .Magnitometer)
        }
    }
    
    private func sendAccelerometerData() {
        if let data = self.motion.accelerometerData {
            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            delegate?.sourceCoreMotionDidChangeRawValues([x, y, z], source: .Accelerometer)
        }
    }
    
    private func sendMotionData() {
        if let data = self.motion.deviceMotion {
            let x = data.attitude.roll
            let y = data.attitude.pitch
            let z = data.attitude.yaw
            delegate?.sourceCoreMotionDidChangeRawValues([x, y, z], source: .Motion)
        }
    }
    
    func requestRandomNumbersFromMotion(count: Int) {
            DispatchQueue.global(qos: .utility).async {
            var numbers: [UInt32] = []
            while numbers.count < count {
                if let data = self.motion.deviceMotion {
                    let x = data.attitude.roll
                    let y = data.attitude.pitch
                    let z = data.attitude.yaw
                    numbers += [x.getLast32(), y.getLast32(), z.getLast32()]
                    self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Motion)
                }
                usleep(16667)
            }
            while numbers.count != count {
                numbers.remove(at: numbers.count - 1)
                self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Motion)
            }
            self.delegate?.sourceCoreMotionDidGetRandomNumbers(numbers, source: .Motion)
            self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Motion)
        }
    }
    
    func requestRandomNumbersFromAccelerometer(count: Int) {
            DispatchQueue.global(qos: .utility).async {
            var numbers: [UInt32] = []
            while numbers.count < count {
                if let data = self.motion.accelerometerData {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    numbers += [x.getFirst32(), y.getFirst32(), z.getFirst32()]
                    self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Accelerometer)
                }
                usleep(16667)
            }
            while numbers.count != count {
                numbers.remove(at: numbers.count - 1)
                self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Accelerometer)
            }
            self.delegate?.sourceCoreMotionDidGetRandomNumbers(numbers, source: .Accelerometer)
            self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Accelerometer)
        }
    }
    
    func requestRandomNumbersFromGyroscope(count: Int) {
        DispatchQueue.global(qos: .utility).async {
            var numbers: [UInt32] = []
            while numbers.count < count {
                if let data = self.motion.gyroData {
                    let x = data.rotationRate.x
                    let y = data.rotationRate.y
                    let z = data.rotationRate.z
                    numbers += [x.getLast32(), y.getLast32(), z.getLast32()]
                    self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Gyroscope)
                }
                usleep(16667)
            }
            while numbers.count != count {
                numbers.remove(at: numbers.count - 1)
                self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Gyroscope)
            }
            self.delegate?.sourceCoreMotionDidGetRandomNumbers(numbers, source: .Gyroscope)
            self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Gyroscope)
        }
    }
    
    func requestRandomNumbersFromMagnitometer(count: Int) {
        DispatchQueue.global(qos: .utility).async {
            var numbers: [UInt32] = []
            while numbers.count < count {
                if let data = self.motion.magnetometerData {
                    let x = data.magneticField.x
                    let y = data.magneticField.y
                    // let z = data.magneticField.z
                    numbers += [UInt32(x.getFirst16()) * 0xFFFF + UInt32(y.getFirst16())]
                    // [x.getFirst32(), y.getFirst32(), z.getFirst32()]
                    self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Magnitometer)
                }
                usleep(16667)
            }
            while numbers.count != count {
                numbers.remove(at: numbers.count - 1)
                self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Magnitometer)
            }
            self.delegate?.sourceCoreMotionDidGetRandomNumbers(numbers, source: .Magnitometer)
            self.delegate?.sourceCoreMotionDidCountRandomNumbers(numbers.count, source: .Magnitometer)
        }
    }


    
}
