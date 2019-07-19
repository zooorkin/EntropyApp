//
//  AboutModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IAboutModel {

    var delegate: IAboutModelDelegate? { get set }
}

protocol IAboutModelDelegate: class {

}

class AboutModel: IAboutModel, IEntropyManagerDelegate {
    

    weak var delegate: IAboutModelDelegate?
    private var entropyManager: IEntropyManager


    init(entropyManager: IEntropyManager) {
        self.entropyManager = entropyManager
        self.entropyManager.delegate = self
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
