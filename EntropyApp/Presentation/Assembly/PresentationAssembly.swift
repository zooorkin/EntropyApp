//
//  PresentationAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class PresentationAssembly: IPresentationAssembly {

    private var servicesAssembly: IServicesAssembly


    required init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }


    func navigationController(rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }

    func entropySourcesListViewController() -> EntropySourcesListViewController {
        let entropyManager = servicesAssembly.entropyManager
        let model = EntropySourcesListModel(entropyManager: entropyManager)
        return EntropySourcesListViewController(presentationAssembly: self, model: model)
    }

    func entropySourceViewController() -> EntropySourceViewController {
        let entropyManager = servicesAssembly.entropyManager
        let model = EntropySourceModel(entropyManager: entropyManager)
        return EntropySourceViewController(presentationAssembly: self, model: model)
    }

    func aboutViewController() -> AboutViewController {
        let entropyManager = servicesAssembly.entropyManager
        let model = AboutModel(entropyManager: entropyManager)
        return AboutViewController(presentationAssembly: self, model: model)
    }

    func reservedViewController() -> ReservedViewController {
        let entropyManager = servicesAssembly.entropyManager
        let model = ReservedModel(entropyManager: entropyManager)
        return ReservedViewController(presentationAssembly: self, model: model)
    }

}
