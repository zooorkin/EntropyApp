//
//  SourceCoreMotion.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceCoreMotion {

    var delegate: ISourceCoreMotionDelegate? {get set}
}


protocol ISourceCoreMotionDelegate {

}


class SourceCoreMotion: ISourceCoreMotion {

    var delegate: ISourceCoreMotionDelegate?

}
