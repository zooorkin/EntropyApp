//
//  ServicesAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

class ServicesAssembly: IServicesAssembly {

    private var coreAssembly: ICoreAssembly


    required init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }


    lazy var entropyManager: IEntropyManager =  {
        let sourceFoundation = coreAssembly.sourceFoundation
        let sourceUIKit = coreAssembly.sourceUIKit
        let sourceCoreLocation = coreAssembly.sourceCoreLocation
        let sourceCoreMotion = coreAssembly.sourceCoreMotion
        let sourceAVFoundation = coreAssembly.sourceAVFoundation
        let sourceDispatch = coreAssembly.sourceDispatch
        let sourceReserved = coreAssembly.sourceReserved
        return EntropyManager(sourceFoundation: sourceFoundation, sourceUIKit: sourceUIKit, sourceCoreLocation: sourceCoreLocation, sourceCoreMotion: sourceCoreMotion, sourceAVFoundation: sourceAVFoundation, sourceDispatch: sourceDispatch, sourceReserved: sourceReserved)
}()


}
