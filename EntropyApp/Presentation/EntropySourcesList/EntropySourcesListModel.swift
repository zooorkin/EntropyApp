//
//  EntropySourcesListModel.swift
//  Entropy
//
//  Created by Андрей Зорькин on 03.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IEntropySourcesListModel {
    var delegate: IEntropySourcesListModelDelegate? { get set }
    var numberOfRows: Int {get}
    func name(ofSource: Int) -> String
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
    func name(ofSource index: Int) -> String{
        if (index >= 0 && index < numberOfRows){
            return entropyManager.entropyList[index]
        }
        fatalError("Неправильный индекс")
    }
    
}
