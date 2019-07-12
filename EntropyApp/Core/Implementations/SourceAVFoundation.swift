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
    
}


protocol ISourceAVFoundationDelegate {
    
    func sourceAVFoundationDidChangeRawValues(_ values: [Float])

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
                                            for i in 0..<24 {
                                                array.append(pointer.advanced(by: i).pointee)
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

}
