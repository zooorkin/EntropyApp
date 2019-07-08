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
    func entropySourceModelDidGetRandomNumber(_ value: UInt32)
}

class EntropySourceModel: IEntropySourceModel, IEntropyManagerDelegate {

    weak var delegate: IEntropySourceModelDelegate?
    private var entropyManager: IEntropyManager
    private let source: SourceEntropy

    init(entropyManager: IEntropyManager, source: SourceEntropy) {
        self.entropyManager = entropyManager
        self.source = source
        self.entropyManager.delegate = self
        entropyManager.start(source: source)
    }
    
    deinit {
        entropyManager.stop(source: source)
    }
    
    func entropyManagerDidGetInformationFromSource(_ text: String) {
        delegate?.entropySourceModelDidGetInformationFromSource(text)
    }
    
    func entropyManagerDidGetRandomNumber(_ value: UInt32) {
        delegate?.entropySourceModelDidGetRandomNumber(value)
    }

}
