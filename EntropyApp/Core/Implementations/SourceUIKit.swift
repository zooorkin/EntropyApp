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
    
    func requestRandomNumbers(count: Int)
}


protocol ISourceUIKitDelegate {
    func sourceUIKitDidChangeRawValues(_ values: [Double])
    func sourceUIKitDidGetRandomNumbers(_ numbers: [UInt32])
    func sourceUIKitDidCountRandomNumbers(_ count: Int)
}


class SourceUIKit: ISourceUIKit {
    
    var sourceName: String = "Foundation"
    
    var sourceDescription: String = "unknown"

    var delegate: ISourceUIKitDelegate?
    
    func touches(touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: UIView())
            let x = Double(location.x)
            let y = Double(location.y)
            delegate?.sourceUIKitDidChangeRawValues([x, y])
            if let requiredCount = requiredCountOfRandomNumbers {
                randomNumbers += [UInt32(x.getFirst16()) * 0xFFFF + UInt32(y.getFirst16())]
                //randomNumbers += [x.getFirst32(), y.getFirst32()]
                delegate?.sourceUIKitDidCountRandomNumbers(randomNumbers.count)
                if randomNumbers.count >= requiredCount {
                    while randomNumbers.count > requiredCount {
                        randomNumbers.remove(at: randomNumbers.count - 1)
                    }
                    delegate?.sourceUIKitDidGetRandomNumbers(randomNumbers)
                    delegate?.sourceUIKitDidCountRandomNumbers(randomNumbers.count)
                    requiredCountOfRandomNumbers = nil
                    randomNumbers = []
                }
            }
        }
    }
    
    var randomNumbers: [UInt32] = []
    var requiredCountOfRandomNumbers: Int?
    
    func requestRandomNumbers(count: Int) {
        requiredCountOfRandomNumbers = count
    }
    

}
