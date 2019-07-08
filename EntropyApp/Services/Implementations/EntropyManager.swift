//
//  EntropyManager.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IEntropyManager {

    var delegate: IEntropyManagerDelegate? {get set}
}


protocol IEntropyManagerDelegate {

}


class EntropyManager: IEntropyManager, ISourceFoundationDelegate, ISourceUIKitDelegate, ISourceCoreLocationDelegate, ISourceCoreMotionDelegate, ISourceAVFoundationDelegate, ISourceDispatchDelegate, ISourceReservedDelegate {

    var delegate: IEntropyManagerDelegate?

    private var sourceFoundation: ISourceFoundation

    private var sourceUIKit: ISourceUIKit

    private var sourceCoreLocation: ISourceCoreLocation

    private var sourceCoreMotion: ISourceCoreMotion

    private var sourceAVFoundation: ISourceAVFoundation

    private var sourceDispatch: ISourceDispatch

    private var sourceReserved: ISourceReserved


    init(sourceFoundation: ISourceFoundation, sourceUIKit: ISourceUIKit, sourceCoreLocation: ISourceCoreLocation, sourceCoreMotion: ISourceCoreMotion, sourceAVFoundation: ISourceAVFoundation, sourceDispatch: ISourceDispatch, sourceReserved: ISourceReserved) {
        self.sourceFoundation = sourceFoundation
        self.sourceUIKit = sourceUIKit
        self.sourceCoreLocation = sourceCoreLocation
        self.sourceCoreMotion = sourceCoreMotion
        self.sourceAVFoundation = sourceAVFoundation
        self.sourceDispatch = sourceDispatch
        self.sourceReserved = sourceReserved
        self.sourceFoundation.delegate = self
        self.sourceUIKit.delegate = self
        self.sourceCoreLocation.delegate = self
        self.sourceCoreMotion.delegate = self
        self.sourceAVFoundation.delegate = self
        self.sourceDispatch.delegate = self
        self.sourceReserved.delegate = self
    }

}