//
//  IPresentationAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IPresentationAssembly {

    init(servicesAssembly: IServicesAssembly)


    func navigationController(rootViewController: UIViewController) -> UINavigationController

    func entropySourcesListViewController() -> EntropySourcesListViewController

    func entropySourceViewController() -> EntropySourceViewController

    func aboutViewController() -> AboutViewController

    func reservedViewController() -> ReservedViewController

}
