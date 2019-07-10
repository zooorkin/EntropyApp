//
//  AboutModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

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
