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
}

protocol IEntropySourceModelDelegate: class {
    func entropySourceModelDidGetInformationFromSource(_ text: String)
    func entropySourceModelDidGetRawValues(_ values: [Double])
    func entropySourceModelDidGetRawValues(_ values: [CGFloat])
    func entropySourceModelDidGetRandomNumbers(_ numbers: [UInt32])
    func entropySourceModelDidGetRandomNumbers(_ numbers: [UInt16])
}

class EntropySourceModel: IEntropySourceModel, IEntropyManagerDelegate {
    

    weak var delegate: IEntropySourceModelDelegate?
    private var entropyManager: IEntropyManager
    let source: SourceEntropy

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
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32]) {
        delegate?.entropySourceModelDidGetRandomNumbers(numbers)
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16]) {
        delegate?.entropySourceModelDidGetRandomNumbers(numbers)
    }
    
    func entropyManagerDidGetRawValues(_ values: [Double]) {
        delegate?.entropySourceModelDidGetRawValues(values)
    }
    
    func touches(touches: Set<UITouch>, with event: UIEvent?) {
        entropyManager.touches(touches: touches, with: event)
    }
    
}
