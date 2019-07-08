//
//  AboutViewController.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, IAboutModelDelegate {

    private let presentationAssembly: IPresentationAssembly

    private var model: IAboutModel


    init(presentationAssembly: IPresentationAssembly, model: IAboutModel) {
        self.presentationAssembly = presentationAssembly
        self.model = model
        super.init(nibName: "AboutViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
    }

}
