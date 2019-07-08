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

}