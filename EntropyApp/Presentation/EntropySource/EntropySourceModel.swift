//
//  EntropySourceModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IEntropySourceModel {

    var delegate: IEntropySourceModelDelegate? { get set }
}

protocol IEntropySourceModelDelegate: class {
    func entropySourceModelDidGetInformationFromSource(_ text: String)
    func entropySourceModelDidGetRawValues(x: Double, y: Double, z: Double)
    func entropySourceModelDidGetRandomNumber(_ value: UInt32)
    func entropySourceModelDidGetRandomNumbers(_ firstValue: UInt32,
                                           _ secondValue: UInt32,
                                           _ thirdValue: UInt32)
    func entropySourceModelDidGetRandomNumber(_ value: UInt16)
    func entropySourceModelDidGetRandomNumbers(_ firstValue: UInt16,
                                           _ secondValue: UInt16,
                                           _ thirdValue: UInt16)
}

class EntropySourceModel: IEntropySourceModel, IEntropyManagerDelegate {

    weak var delegate: IEntropySourceModelDelegate?
    private var entropyManager: IEntropyManager
    private let source: SourceEntropy

    init(entropyManager: IEntropyManager, source: SourceEntropy) {
        self.entropyManager = entropyManager
        self.source = source
        self.entropyManager.delegate = self
        print("Сервис \(source) запускается...")
        entropyManager.start(source: source)
    }
    
    deinit {
        print("Сервис \(source) останавливается...")
        entropyManager.stop(source: source)
    }
    
    func entropyManagerDidGetInformationFromSource(_ text: String) {
        delegate?.entropySourceModelDidGetInformationFromSource(text)
    }
    
    func entropyManagerDidGetRandomNumber(_ value: UInt32) {
        delegate?.entropySourceModelDidGetRandomNumber(value)
    }
    
    func entropyManagerDidGetRandomNumbers(_ firstValue: UInt32, _ secondValue: UInt32, _ thirdValue: UInt32) {
        delegate?.entropySourceModelDidGetRandomNumbers(firstValue, secondValue, thirdValue)
    }
    
    func entropyManagerDidGetRandomNumber(_ value: UInt16) {
        delegate?.entropySourceModelDidGetRandomNumber(value)
    }
    
    func entropyManagerDidGetRandomNumbers(_ firstValue: UInt16, _ secondValue: UInt16, _ thirdValue: UInt16) {
        delegate?.entropySourceModelDidGetRandomNumbers(firstValue, secondValue, thirdValue)
    }
    
    func entropyManagerDidGetRawValues(x: Double, y: Double, z: Double) {
        delegate?.entropySourceModelDidGetRawValues(x: x, y: y, z: z)
    }
    
    func entropyManagerDidGetRawValue(_ value: Double) {
        
    }
    
}
