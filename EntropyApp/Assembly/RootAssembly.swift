//
//  RootAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

class RootAssembly: IRootAssembly {

    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(servicesAssembly: servicesAssembly)

    private lazy var servicesAssembly: IServicesAssembly = ServicesAssembly(coreAssembly: coreAssembly)

    private lazy var coreAssembly: ICoreAssembly = CoreAssembly()

}
