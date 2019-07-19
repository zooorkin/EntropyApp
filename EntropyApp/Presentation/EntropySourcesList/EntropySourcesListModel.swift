//
//  EntropySourcesListModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 03.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IEntropySourcesListModel {
    var delegate: IEntropySourcesListModelDelegate? { get set }
    var numberOfRows: Int {get}
    func sourceEntropyName(at index: Int) -> String
    func sourceEntropy(at index: Int) -> SourceEntropy
    func sourceEntropyIsEnabled(at index: Int) -> Bool
}

protocol IEntropySourcesListModelDelegate: class {
    
}

class EntropySourcesListModel: IEntropySourcesListModel, IEntropyManagerDelegate {
    
    weak var delegate: IEntropySourcesListModelDelegate?
    private var entropyManager: IEntropyManager

    init(entropyManager: IEntropyManager) {
        self.entropyManager = entropyManager
        self.entropyManager.delegate = self
    }
    
    var numberOfRows: Int {
        return entropyManager.numberOfEntropySources
    }
    
    func sourceEntropyName(at index: Int) -> String {
        if (index >= 0 && index < numberOfRows){
            return entropyManager.sourceEntropyName(at: index)
        }
        fatalError("Неправильный индекс")
    }
    
    func sourceEntropy(at index: Int) -> SourceEntropy {
        if (index >= 0 && index < numberOfRows){
            return entropyManager.sourceEntropy(at: index)
        }
        fatalError("Неправильный индекс")
    }
    
    func sourceEntropyIsEnabled(at index: Int) -> Bool {
        if (index >= 0 && index < numberOfRows){
            return entropyManager.sourceEntropyIsEnabled(at: index)
        }
        fatalError("Неправильный индекс")
    }
    
    func entropyManagerDidGetInformation(_ text: String, source: SourceEntropy) {
        
    }
    
    func entropyManagerDidGetRawValues(_ values: [Double], source: SourceEntropy) {
        
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32], source: SourceEntropy) {
        
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16], source: SourceEntropy) {
        
    }
    
    func entropyManagerDidGetRawValues(_ values: [Float], source: SourceEntropy) {
        
    }
    
    func entropyManagerDidCountRandomNumbers(_ count: Int, source: SourceEntropy) {
        
    }

}
