//
//  SourceFoundation.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceFoundation {

    var delegate: ISourceFoundationDelegate? {get set}
}


protocol ISourceFoundationDelegate {

}


class SourceFoundation: ISourceFoundation {

    var delegate: ISourceFoundationDelegate?

}
