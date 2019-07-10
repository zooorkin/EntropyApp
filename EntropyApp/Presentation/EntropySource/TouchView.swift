//
//  TouchView.swift
//  EntropyApp
//
//  Created by Андрей Зорькин on 10/07/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol ITouchDelegate {
    func touches(touches: Set<UITouch>, with event: UIEvent?)
}

class TouchView: UIView {
    
    public var delegate: ITouchDelegate?
    
    private var point: UIView?
    
    private func movePointTo(x: CGFloat, y: CGFloat) {
        if let strongPoint = point {
            let p = CGPoint(x: x, y: y)
            strongPoint.frame.origin = p
            strongPoint.setNeedsDisplay()
            self.setNeedsDisplay()
        } else {
            point = UIView(frame: CGRect(x: x, y: y, width: 4, height: 4))
            point!.backgroundColor = .red
            self.addSubview(point!)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.touches(touches: touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            movePointTo(x: location.x, y: location.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        delegate?.touches(touches: touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            movePointTo(x: location.x, y: location.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        delegate?.touches(touches: touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            movePointTo(x: location.x, y: location.y)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        delegate?.touches(touches: touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            movePointTo(x: location.x, y: location.y)
        }
    }

}
