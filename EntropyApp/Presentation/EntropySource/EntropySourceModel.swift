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

}

class EntropySourceModel: IEntropySourceModel, IEntropyManagerDelegate {

    weak var delegate: IEntropySourceModelDelegate?
    private var entropyManager: IEntropyManager


    init(entropyManager: IEntropyManager) {
        self.entropyManager = entropyManager
        self.entropyManager.delegate = self
    }

}
