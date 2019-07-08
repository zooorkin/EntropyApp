//
//  IServicesAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IServicesAssembly {

    init(coreAssembly: ICoreAssembly)

    var entropyManager: IEntropyManager {get}


}
