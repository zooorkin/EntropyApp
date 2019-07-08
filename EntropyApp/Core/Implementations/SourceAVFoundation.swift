//
//  SourceAVFoundation.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceAVFoundation {

    var delegate: ISourceAVFoundationDelegate? {get set}
}


protocol ISourceAVFoundationDelegate {

}


class SourceAVFoundation: ISourceAVFoundation {

    var delegate: ISourceAVFoundationDelegate?

}
