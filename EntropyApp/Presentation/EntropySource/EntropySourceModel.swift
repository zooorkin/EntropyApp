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
    func entropySourceModelDidGetExpectation(result: String)
    func entropySourceModelDidGetRealExpectation(result: String)
    func entropySourceModelDidGetVarience(result: String)
    func entropySourceModelDidGetRealVarience(result: String)
    func entropySourceModelDidGetVarienceDiff(result: String)
    func entropySourceModelDidGetExpectationDiff(result: String)
    func entropySourceModelDidEnd()
    func entropySourceModelDidCountRandomNumbers(_ count: Int)
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
    }
    
    deinit {
        print("Сервис \(source) останавливается...")
        entropyManager.stop(source: source)
        print("entropyManager.stop(source: source) done")
    }
    
    func entropyManagerDidGetInformation(_ text: String, source: SourceEntropy) {
        guard source == self.source else { return }
        delegate?.entropySourceModelDidGetInformationFromSource(text)
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32], source: SourceEntropy) {
        guard source == self.source else { return }
        delegate?.entropySourceModelDidGetRandomNumbers(numbers)
        delegate?.entropySourceModelDidGetPearsonTest(result: statistics.pearsonTest(numbers: numbers))
        let expectation = statistics.expectation(numbers: numbers)
        let realExpectation = statistics.realExpectation()
        let varience = statistics.varience(numbers: numbers, expectation: expectation)
        let realVarience = statistics.realVarience()
        let expectationDiff = statistics.expectationDiff(expectation: expectation, realExpectation: realExpectation)
        let variationDiff = statistics.varienceDiff(varience: varience, realVarience: realVarience)
        delegate?.entropySourceModelDidGetExpectation(result: String(expectation))
        delegate?.entropySourceModelDidGetRealExpectation(result: String(realExpectation))
        delegate?.entropySourceModelDidGetVarience(result: String(varience))
        delegate?.entropySourceModelDidGetRealVarience(result: String(realVarience))
        delegate?.entropySourceModelDidGetExpectationDiff(result: String(expectationDiff))
        delegate?.entropySourceModelDidGetVarienceDiff(result: String(variationDiff))
        delegate?.entropySourceModelDidEnd()
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16], source: SourceEntropy) {
        guard source == self.source else { return }
        delegate?.entropySourceModelDidGetRandomNumbers(numbers)
    }
    
    func entropyManagerDidGetRawValues(_ values: [Double], source: SourceEntropy) {
        guard source == self.source else { return }
        delegate?.entropySourceModelDidGetRawValues(values)
    }
    
    func entropyManagerDidGetRawValues(_ values: [Float], source: SourceEntropy) {
        guard source == self.source else { return }
        delegate?.entropySourceModelDidGetRawValues(values)
    }
    
    func entropyManagerDidCountRandomNumbers(_ count: Int, source: SourceEntropy) {
        guard source == self.source else { return }
        delegate?.entropySourceModelDidCountRandomNumbers(count)
    }
    
    
    func touches(touches: Set<UITouch>, with event: UIEvent?) {
        entropyManager.touches(touches: touches, with: event)
    }
    
    func requestRandomNumbers(count: Int){
        entropyManager.requestRandomNumbers(count: count, for: source)
    }
    
}
