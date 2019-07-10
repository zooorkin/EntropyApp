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
    
    func entropyManagerDidGetRandomNumbers(_ firstValue: UInt32, _ secondValue: UInt32, _ thirdValue: UInt32) {

    }
    
    func entropyManagerDidGetRandomNumber(_ value: UInt16) {
        
    }
    
    func entropyManagerDidGetRandomNumbers(_ firstValue: UInt16, _ secondValue: UInt16, _ thirdValue: UInt16) {
        
    }
    
    func entropyManagerDidGetRawValue(_ value: Double) {
        
    }
    
    func entropyManagerDidGetRawValues(x: Double, y: Double, z: Double) {
        
    }
    
}
