//
//  ReservedModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IReservedModel {

    var delegate: IReservedModelDelegate? { get set }
}

protocol IReservedModelDelegate: class {

}

class ReservedModel: IReservedModel, IEntropyManagerDelegate {

    weak var delegate: IReservedModelDelegate?
    private var entropyManager: IEntropyManager


    init(entropyManager: IEntropyManager) {
        self.entropyManager = entropyManager
        self.entropyManager.delegate = self
    }
    
    func entropyManagerDidGetInformationFromSource(_ text: String) {
        
    }
    
    func entropyManagerDidGetRawValues(_ values: [Double]) {
        
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt32]) {
        
    }
    
    func entropyManagerDidGetRandomNumbers(_ numbers: [UInt16]) {
        
    }
    
}
