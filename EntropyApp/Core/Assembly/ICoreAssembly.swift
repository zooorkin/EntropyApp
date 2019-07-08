//
//  ICoreAssembly.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ICoreAssembly {

    var sourceFoundation: ISourceFoundation {get}

    var sourceUIKit: ISourceUIKit {get}

    var sourceCoreLocation: ISourceCoreLocation {get}

    var sourceCoreMotion: ISourceCoreMotion {get}

    var sourceAVFoundation: ISourceAVFoundation {get}

    var sourceDispatch: ISourceDispatch {get}

    var sourceReserved: ISourceReserved {get}

}
