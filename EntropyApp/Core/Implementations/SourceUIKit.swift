//
//  SourceUIKit.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol ISourceUIKit {

    var delegate: ISourceUIKitDelegate? {get set}
    
    func touches(touches: Set<UITouch>, with event: UIEvent?)
}


protocol ISourceUIKitDelegate {
    func sourceUIKitDidChangeRawValues(_ values: [Double])
}


class SourceUIKit: ISourceUIKit {

    var delegate: ISourceUIKitDelegate?
    
    func touches(touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: UIView())
            let x = Double(location.x)
            let y = Double(location.y)
            delegate?.sourceUIKitDidChangeRawValues([x, y])
        }
    }

}
