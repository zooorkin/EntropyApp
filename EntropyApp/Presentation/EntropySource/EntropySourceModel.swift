//
//  EntropySourceModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IEntropySourceModel: ITouchDelegate {

    var delegate: IEntropySourceModelDelegate? { get set }
    var source: SourceEntropy {get}
    func touches(touches: Set<UITouch>, with event: UIEvent?)
    func requestRandomNumbers(count: Int)
}

protocol IEntropySourceModelDelegate: class {
    func entropySourceModelDidGetInformationFromSource(_ text: String)
    func entropySourceModelDidGetRawValues(_ values: [Double])
    func entropySourceModelDidGetRawValues(_ values: [Float])
    func entropySourceModelDidGetRandomNumbers(_ numbers: [UInt32])
    func entropySourceModelDidGetRandomNumbers(_ numbers: [UInt16])
    func entropySourceModelDidGetPearsonTest(result: String)
}

class EntropySourceModel: IEntropySourceModel, IEntropyManagerDelegate {
    

    weak var delegate: IEntropySourceModelDelegate?
    
    private var entropyManager: IEntropyManager
    
    private var statistics: Statistics
    
    let source: SourceEntropy

    
    init(entropyManager: IEntropyManager, source: SourceEntropy) {
        self.entropyManager = entropyManager
        self.source = source
        self.statistics = Statistics()
        self.entropyManager.delegate = self
        print("Сервис \(source) запускается...")
        entropyManager.start(source: source)
        entropyManager.requestRandomNumbers(count: 100, for: source)
    }
    
    deinit {
        print("Сервис \(source) останавливается...")
        entropyManager.stop(source: source)
    }
    
    func entropyManagerDidGetInformationFromSource(_ text: String) {
        delegate?.entropySourceModelDidGetInformationFromSource(text)
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropySourceModelDidGetRandomNumbers(numbers)
        delegate?.entropySourceModelDidGetPearsonTest(result: statistics.pearsonTest(numbers: numbers))
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16]) {
        delegate?.entropySourceModelDidGetRandomNumbers(numbers)
    }
    
    func entropyManagerDidGetRawValues(_ values: [Double]) {
        delegate?.entropySourceModelDidGetRawValues(values)
    }
    
    func entropyManagerDidGetRawValues(_ values: [Float]) {
        delegate?.entropySourceModelDidGetRawValues(values)
    }
    
    func touches(touches: Set<UITouch>, with event: UIEvent?) {
        entropyManager.touches(touches: touches, with: event)
    }
    
    func requestRandomNumbers(count: Int){
        entropyManager.requestRandomNumbers(count: count, for: source)
    }
    
}
