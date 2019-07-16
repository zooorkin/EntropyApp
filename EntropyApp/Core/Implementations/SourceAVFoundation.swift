//
//  SourceAVFoundation.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import AVFoundation

protocol ISourceAVFoundation {

    var delegate: ISourceAVFoundationDelegate? {get set}
    
    func startMicrophone()
    
    func stopMicrophone()
    
    func requestRandomNumbers(count: Int)
    
}


protocol ISourceAVFoundationDelegate {
    
    func sourceAVFoundationDidChangeRawValues(_ values: [Float])
    func sourceAVFoundationDidGetRandomNumbers(_ numbers: [UInt32])

}


class SourceAVFoundation: ISourceAVFoundation {

    var delegate: ISourceAVFoundationDelegate?
    
    let audioEngine = AVAudioEngine()
    
    func startMicrophone() {
        AVAudioSession.sharedInstance().requestRecordPermission { (response) in
            if response == true {
                let inpputNode = self.audioEngine.inputNode
                let bus = 0
                inpputNode.installTap(onBus: bus,
                                      bufferSize: 2048,
                                      format: inpputNode.inputFormat(forBus: bus)){
                                        (buffer: AVAudioPCMBuffer, audioTime  : AVAudioTime) in
                                        if let pointer = buffer.floatChannelData?.pointee {
                                            var array = [Float]()
                                            for i in 0..<20 {
                                                let x = pointer.advanced(by: 2*i).pointee
                                                let y = pointer.advanced(by: 2*i+1).pointee
                                                array.append(x)
                                                array.append(y)
                                                self.addRandomNumbers(x: Double(x), y: Double(y))
                                            }
                                            self.delegate?.sourceAVFoundationDidChangeRawValues(array)
                                        }
                }
                self.audioEngine.prepare()
                do {
                    try self.audioEngine.start()
                } catch { }
            } else { }
        }
    }
    
    func stopMicrophone() {
        let bus = 0
        audioEngine.inputNode.removeTap(onBus: bus)
        audioEngine.stop()
    }
    
    private func addRandomNumbers(x: Double, y: Double){
        if let requiredCount = requiredCountOfRandomNumbers {
            randomNumbers += [UInt32(x.getFirst16()) * 0xFFFF + UInt32(y.getFirst16())]
            if randomNumbers.count >= requiredCount {
                while randomNumbers.count > requiredCount {
                    randomNumbers.remove(at: randomNumbers.count - 1)
                }
                delegate?.sourceAVFoundationDidGetRandomNumbers(randomNumbers)
                requiredCountOfRandomNumbers = nil
                randomNumbers = []
            }
        }
    }
    
    var randomNumbers: [UInt32] = []
    var requiredCountOfRandomNumbers: Int?
    
    func requestRandomNumbers(count: Int) {
        requiredCountOfRandomNumbers = count
    }

}
