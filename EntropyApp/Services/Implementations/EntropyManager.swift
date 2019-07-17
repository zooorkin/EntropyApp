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
    var numberOfEntropySources: Int {get}
    func start(source: SourceEntropy)
    func stop(source: SourceEntropy)
    func touches(touches: Set<UITouch>, with event: UIEvent?)
    func requestRandomNumbers(count: Int, for source: SourceEntropy)
}

protocol IEntropyManagerDelegate: class {
    
    func entropyManagerDidGetInformationFromSource(_ text: String)
    // Сырые значения
    func entropyManagerDidGetRawValues(_ values: [Double])
    
    func entropyManagerDidGetRawValues(_ values: [Float])
    // Случайные числа (32 бита)
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32])
    // Случайные числа (16 бит)
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16])
}


enum SourceEntropy {
    case Motion
    case Accelerometer
    case Gyroscope
    case Magnitometer
    case Location
    case Touches
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

    
    private var entropyList: [(sourceEntropy: SourceEntropy, name: String)]
    
    func sourceEntropyName(at index: Int) -> String {
        return entropyList[index].name
    }
    
    func sourceEntropy(at index: Int) -> SourceEntropy {
        return entropyList[index].sourceEntropy
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
        self.entropyList = [(sourceEntropy: .Undefined, name: "Время"),
                            (sourceEntropy: .Touches, name: "Прикосновение"),
                            (sourceEntropy: .Location, name: "Географическое местоположение"),
                            (sourceEntropy: .Motion, name: "Положение в пространстве"),
                            (sourceEntropy: .Accelerometer, name: "Акселерометр"),
                            (sourceEntropy: .Gyroscope, name: "Гироскоп"),
                            (sourceEntropy: .Magnitometer, name: "Магнитометр"),
                            (sourceEntropy: .Microphone, name: "Микрофон"),
                            (sourceEntropy: .Undefined, name: "Камера"),
                            (sourceEntropy: .Undefined, name: "Многопоточность")]
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
    
    func sourceCoreMotionDidChangeRawValues(_ values: [Double]) {
        delegate?.entropyManagerDidGetRawValues(values)
    }
    
    func sourceCoreMotionDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers)
    }
    
    func sourceCoreMotionDidGetRandomNumbers(_ numbers: [UInt16]) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers)
    }

    func sourceCoreLocationDidChangeRawValues(_ values: [Double]) {
        delegate?.entropyManagerDidGetRawValues(values)
    }
    
    func sourceUIKitDidChangeRawValues( _ values: [Double]) {
        delegate?.entropyManagerDidGetRawValues(values)
    }
    
    func sourceUIKitDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers)
    }
    
    func sourceAVFoundationDidChangeRawValues(_ values: [Float]) {
        delegate?.entropyManagerDidGetRawValues(values)
    }
    
    func sourceAVFoundationDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropyManagerDidGetRandomNumbers(numbers)
    }
    
    func requestRandomNumbers(count: Int, for source: SourceEntropy) {
        switch source {
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
