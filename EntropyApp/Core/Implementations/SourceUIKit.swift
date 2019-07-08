//
//  SourceUIKit.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ISourceUIKit {

    var delegate: ISourceUIKitDelegate? {get set}
}


protocol ISourceUIKitDelegate {

}


class SourceUIKit: ISourceUIKit {

    var delegate: ISourceUIKitDelegate?

}
