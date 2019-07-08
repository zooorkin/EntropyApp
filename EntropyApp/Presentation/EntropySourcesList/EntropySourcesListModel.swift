//
//  EntropySourcesListModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IEntropySourcesListModel {

    var delegate: IEntropySourcesListModelDelegate? { get set }
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

}
