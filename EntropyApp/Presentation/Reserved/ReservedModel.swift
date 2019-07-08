//
//  ReservedModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

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
    
    func entropyManagerDidGetRandomNumber(_ value: UInt32) {
        
    }

}
