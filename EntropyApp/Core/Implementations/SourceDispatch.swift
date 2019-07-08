//
//  SourceDispatch.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceDispatch {

    var delegate: ISourceDispatchDelegate? {get set}
}


protocol ISourceDispatchDelegate {

}


class SourceDispatch: ISourceDispatch {

    var delegate: ISourceDispatchDelegate?

}
