//
//  EntropySourcesListViewController.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class EntropySourcesListViewController: UIViewController, IEntropySourcesListModelDelegate {

    private let presentationAssembly: IPresentationAssembly

    private var model: IEntropySourcesListModel


    init(presentationAssembly: IPresentationAssembly, model: IEntropySourcesListModel) {
        self.presentationAssembly = presentationAssembly
        self.model = model
        super.init(nibName: "EntropySourcesListViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
    }

}
