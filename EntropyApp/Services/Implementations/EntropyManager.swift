//
//  EntropyManager.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IEntropyManager {

    var delegate: IEntropyManagerDelegate? {get set}
    func sourceEntropyName(at index: Int) -> String
    func sourceEntropy(at index: Int) -> SourceEntropy
    var numberOfEntropySources: Int {get}
    func start(source: SourceEntropy)
    func stop(source: SourceEntropy)
}


protocol IEntropyManagerDelegate: class {
    func entropyManagerDidGetInformationFromSource(_ text: String)
    func entropyManagerDidGetRandomNumber(_ value: UInt32)
}


enum SourceEntropy {
    case Motion
    case Accelerometer
    case Gyroscope
    case Magnitometer
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
        case .Motion:
            sourceCoreMotion.startMotion()
        case .Accelerometer:
            sourceCoreMotion.startAccelerometer()
        case .Gyroscope:
            sourceCoreMotion.startGyroscope()
        case .Magnitometer:
            sourceCoreMotion.startMagnitometer()
        case .Undefined:
            break;
        }
    }
    
    func stop(source: SourceEntropy) {
        switch source {
        case .Motion:
            sourceCoreMotion.stopMotion()
        case .Accelerometer:
            sourceCoreMotion.stopAccelerometer()
        case .Gyroscope:
            sourceCoreMotion.stopGyroscope()
        case .Magnitometer:
            sourceCoreMotion.stopMagnitometer()
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
                            (sourceEntropy: .Undefined, name: "Прикосновение"),
                            (sourceEntropy: .Undefined, name: "Географическое местоположение"),
                            (sourceEntropy: .Motion, name: "Положение в пространстве"),
                            (sourceEntropy: .Accelerometer, name: "Акселерометр"),
                            (sourceEntropy: .Gyroscope, name: "Гироскоп"),
                            (sourceEntropy: .Magnitometer, name: "Магнитометр"),
                            (sourceEntropy: .Undefined, name: "Микрофон"),
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
    
    func sourceCoreMotionDidChangeRawValues(roll: Double, pitch: Double, yaw: Double) {
        delegate?.entropyManagerDidGetInformationFromSource("roll: \(roll)\npitch: \(pitch)\nyaw: \(yaw)")
    }
    
    func sourceCoreMotionDidChangeRawValues(x: Double, y: Double, z: Double) {
        delegate?.entropyManagerDidGetInformationFromSource("x: \(x)\ny: \(y)\nz: \(z)")
    }
    
    func sourceCoreMotionDidGetRandomNumber(_ value: UInt32) {
        
    }

}
