//
//  CoreAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

class CoreAssembly: ICoreAssembly {

    lazy var sourceFoundation: ISourceFoundation = SourceFoundation()

    lazy var sourceUIKit: ISourceUIKit = SourceUIKit()

    lazy var sourceCoreLocation: ISourceCoreLocation = SourceCoreLocation()

    lazy var sourceCoreMotion: ISourceCoreMotion = SourceCoreMotion()

    lazy var sourceAVFoundation: ISourceAVFoundation = SourceAVFoundation()

    lazy var sourceDispatch: ISourceDispatch = SourceDispatch()

    lazy var sourceReserved: ISourceReserved = SourceReserved()

}
