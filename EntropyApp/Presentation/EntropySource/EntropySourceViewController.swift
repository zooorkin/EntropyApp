//
//  EntropySourceViewController.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class EntropySourceViewController: UIViewController, IEntropySourceModelDelegate {

    @IBOutlet weak var informationLabel: UILabel!
    
    private let presentationAssembly: IPresentationAssembly

    private var model: IEntropySourceModel


    init(presentationAssembly: IPresentationAssembly, model: IEntropySourceModel) {
        self.presentationAssembly = presentationAssembly
        self.model = model
        super.init(nibName: "EntropySourceViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
    }
    
    func entropySourceModelDidGetInformationFromSource(_ text: String) {
        informationLabel.text = text
    }
    
    func entropySourceModelDidGetRandomNumber(_ value: UInt32) {
        
    }

}
