//
//  SourceReserved.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceReserved {

    var delegate: ISourceReservedDelegate? {get set}
}


protocol ISourceReservedDelegate {

}


class SourceReserved: ISourceReserved {

    var delegate: ISourceReservedDelegate?

}
