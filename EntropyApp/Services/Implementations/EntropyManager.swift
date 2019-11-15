//
//  EntropyManager.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IEntropyManager {

    var delegate: IEntropyManagerDelegate? {get set}
    func sourceEntropyName(at index: Int) -> String
    func sourceEntropy(at index: Int) -> SourceEntropy
    func sourceEntropyIsEnabled(at index: Int) -> Bool
    var numberOfEntropySources: Int {get}
    func start(source: SourceEntropy)
    func stop(source: SourceEntropy)
    func touches(touches: Set<UITouch>, with event: UIEvent?)
    func requestRandomNumbers(count: Int, for source: SourceEntropy)
}

protocol IEntropyManagerDelegate: class {
    
    func entropyManagerDidGetInformation(_ text: String, source: SourceEntropy)
    // Сырые значения
    func entropyManagerDidGetRawValues(_ values: [Double], source: SourceEntropy)
    
    func entropyManagerDidGetRawValues(_ values: [Float], source: SourceEntropy)
    // Случайные числа (32 бита)
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32], source: SourceEntropy)
    // Случайные числа (16 бит)
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16], source: SourceEntropy)
    //
    func entropyManagerDidCountRandomNumbers(_ count: Int, source: SourceEntropy)
}

protocol ISourceEntropy {
    
    var sourceName: String { get }
    var sourceDescription: String { get }
}

enum SourceEntropy {
    
    case Touches
    case Location
    case Altimeter
    case Motion
    case Accelerometer
    case Gyroscope
    case Magnitometer
    case Microphone
    case Undefined
}


class EntropyManager: IEntropyManager, ISourceFoundationDelegate, ISourceUIKitDelegate, ISourceCoreLocationDelegate, ISourceCoreMotionDelegate, ISourceAVFoundationDelegate, ISourceDispatchDelegate, ISourceReservedDelegate {

    weak var delegate: IEntropyManagerDelegate?

    private var sourceFoundation: ISourceFoundation

    private var sourceUIKit: ISourceUIKit

    private var sourceCoreLocation: ISourceCoreLocation

    private var sourceCoreMotion: ISourceCoreMotion

    private var sourceAVFoundation: ISourceAVFoundation

    private var sourceDispatch: ISourceDispatch

    private var sourceReserved: ISourceReserved

    
    private var entropyList: [(sourceEntropy: SourceEntropy, name: String, enabled: Bool)]
    
    func sourceEntropyName(at index: Int) -> String {
        return entropyList[index].name
    }
    
    func sourceEntropy(at index: Int) -> SourceEntropy {
        return entropyList[index].sourceEntropy
    }
    
    func sourceEntropyIsEnabled(at index: Int) -> Bool {
        return entropyList[index].enabled
    }
    
    var numberOfEntropySources: Int {
        return entropyList.count
    }
    
    func start(source: SourceEntropy) {
        switch source {
        case .Touches:
            break;
        case .Motion:
            self.sourceCoreMotion.startMotion()
        case .Accelerometer:
            self.sourceCoreMotion.startAccelerometer()
        case .Gyroscope:
            self.sourceCoreMotion.startGyroscope()
        case .Magnitometer:
            self.sourceCoreMotion.startMagnitometer()
        case .Altimeter:
            self.sourceCoreLocation.startAltimeter()
        case .Location:
            self.sourceCoreLocation.startLocation()
        case .Microphone:
            self.sourceAVFoundation.startMicrophone()
        case .Undefined:
            break;
        }
    }
    
    func stop(source: SourceEntropy) {
        switch source {
        case .Touches:
            break;
        case .Motion:
            sourceCoreMotion.stopMotion()
        case .Accelerometer:
            sourceCoreMotion.stopAccelerometer()
        case .Gyroscope:
            sourceCoreMotion.stopGyroscope()
        case .Magnitometer:
            sourceCoreMotion.stopMagnitometer()
        case .Altimeter:
            sourceCoreLocation.stopAltimeter()
        case .Location:
            sourceCoreLocation.stopLocation()
        case .Microphone:
            sourceAVFoundation.stopMicrophone()
        case .Undefined:
            break;
        }
    }

    init(sourceFoundation: ISourceFoundation, sourceUIKit: ISourceUIKit, sourceCoreLocation: ISourceCoreLocation, sourceCoreMotion: ISourceCoreMotion, sourceAVFoundation: ISourceAVFoundation, sourceDispatch: ISourceDispatch, sourceReserved: ISourceReserved) {
        self.sourceFoundation = sourceFoundation
        self.sourceUIKit = sourceUIKit
        self.sourceCoreLocation = sourceCoreLocation
        self.sourceCoreMotion = sourceCoreMotion
        self.sourceAVFoundation = sourceAVFoundation
        self.sourceDispatch = sourceDispatch
        self.sourceReserved = sourceReserved
        var entropyList: [(sourceEntropy: SourceEntropy, name: String, enabled: Bool)] = []
        entropyList += [(sourceEntropy: .Undefined, name: "Время", enabled: false)]
        for source in [SourceEntropy.Touches, .Location, .Altimeter, .Motion, .Accelerometer, .Gyroscope, .Magnitometer, .Microphone] {
            entropyList += [ (sourceEntropy: source, name: source.sourceName, enabled: true)]
        }
        entropyList += [(sourceEntropy: .Undefined, name: "Камера", enabled: false),
                        (sourceEntropy: .Undefined, name: "Многопоточность", enabled: false)]
        self.entropyList = entropyList
        self.sourceFoundation.delegate = self
        self.sourceUIKit.delegate = self
        self.sourceCoreLocation.delegate = self
        self.sourceCoreMotion.delegate = self
        self.sourceAVFoundation.delegate = self
        self.sourceDispatch.delegate = self
        self.sourceReserved.delegate = self
    }
    
    func touches(touches: Set<UITouch>, with event: UIEvent?) {
        sourceUIKit.touches(touches: touches, with: event)
    }
    
    private func sourceEntropy(_ source: SourceMotion) -> SourceEntropy {
        switch source {
        case .Motion: return .Motion
        case .Accelerometer: return .Accelerometer
        case .Gyroscope: return .Gyroscope
        case .Magnitometer: return .Magnitometer
        }
    }
    
    func sourceCoreMotionDidChangeRawValues(_ values: [Double], source: SourceMotion) {
        delegate?.entropyManagerDidGetRawValues(values, source: sourceEntropy(source))
    }
    
    func sourceCoreMotionDidGetRandomNumbers(_ numbers: [UInt32], source: SourceMotion) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers, source: sourceEntropy(source))
    }
    
    func sourceCoreMotionDidGetRandomNumbers(_ numbers: [UInt16], source: SourceMotion) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers, source: sourceEntropy(source))
    }
    
    func sourceCoreMotionDidCountRandomNumbers(_ count: Int, source: SourceMotion) {
        delegate?.entropyManagerDidCountRandomNumbers(count, source: sourceEntropy(source))
    }
    
    private func sourceEntropy(_ source: SourceLocation) -> SourceEntropy {
        switch source {
        case .Location: return .Location
        case .Altimeter: return .Altimeter
        }
    }
    
    func sourceCoreLocationDidChangeRawValues(_ values: [Double], source: SourceLocation) {
        delegate?.entropyManagerDidGetRawValues(values, source: sourceEntropy(source))
    }
    
    func sourceCoreLocationDidGetRandomNumbers(_ numbers: [UInt32], source: SourceLocation) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers, source: sourceEntropy(source))
    }
    
    func sourceCoreLocationDidCountRandomNumbers(_ count: Int, source: SourceLocation) {
        delegate?.entropyManagerDidCountRandomNumbers(count, source: sourceEntropy(source))
    }
    
    
    func sourceUIKitDidChangeRawValues( _ values: [Double]) {
        delegate?.entropyManagerDidGetRawValues(values, source: .Touches)
    }
    
    func sourceUIKitDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers, source: .Touches)
    }
    
    func sourceUIKitDidCountRandomNumbers(_ count: Int) {
        delegate?.entropyManagerDidCountRandomNumbers(count, source: .Touches)
    }
    
    
    func sourceAVFoundationDidChangeRawValues(_ values: [Float]) {
        delegate?.entropyManagerDidGetRawValues(values, source: .Microphone)
    }
    
    func sourceAVFoundationDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers, source: .Microphone)
    }
    
    func sourceAVFoundationDidCountRandomNumbers(_ count: Int) {
        delegate?.entropyManagerDidCountRandomNumbers(count, source: .Microphone)
    }
    
    func requestRandomNumbers(count: Int, for source: SourceEntropy) {
        switch source {
        case .Location:
            sourceCoreLocation.requestRandomNumbers(count: count)
        case .Altimeter:
            sourceCoreLocation.requestRandomNumbers(count: count)
        case .Motion:
            sourceCoreMotion.requestRandomNumbersFromMotion(count: count)
        case .Accelerometer:
            sourceCoreMotion.requestRandomNumbersFromAccelerometer(count: count)
        case .Gyroscope:
            sourceCoreMotion.requestRandomNumbersFromGyroscope(count: count)
        case .Magnitometer:
            sourceCoreMotion.requestRandomNumbersFromMagnitometer(count: count)
        case .Touches:
            sourceUIKit.requestRandomNumbers(count: count)
        case .Microphone:
            sourceAVFoundation.requestRandomNumbers(count: count)
        default:
            break;
        }
    }
    
}
