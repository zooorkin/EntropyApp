//
//  SourceCoreLocation.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceCoreLocation {

    var delegate: ISourceCoreLocationDelegate? {get set}
}


protocol ISourceCoreLocationDelegate {

}


class SourceCoreLocation: ISourceCoreLocation {

    var delegate: ISourceCoreLocationDelegate?

}
