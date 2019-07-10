//
//  Double.swift
//  EntropyApp
//
//  Created by Андрей Зорькин on 10/07/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

extension Double {
    // Возвращает младшие 4 байта мантиссы
    func getLast32() -> UInt32 {
        return UInt32(self.significandBitPattern & 0xFFFFFFFF)
    }
    // Возвращает младшие 4 байта мантиссы
    func getFirst32() -> UInt32 {
        return UInt32(self.significandBitPattern & 0xFFFFFFFF00000 / 1048576)
    }
    
    // Возвращает младшие 2 байта мантиссы
    func getLast16() -> UInt16 {
        return UInt16(self.significandBitPattern & 0xFFFF)
    }
    
    // - - A B
    // C D E F
    // A - содержит 4 бита информации
    // B, C, D, E, F, G - 8 бит информации
    func getMantissa() -> (A: UInt8, B: UInt8, C: UInt8, D: UInt8, E: UInt8, F: UInt8, G: UInt8) {
        let A = UInt8(self.significandBitPattern & 0xFF000000000000 / 0x1000000000000)
        let B = UInt8(self.significandBitPattern & 0xFF0000000000   / 0x10000000000)
        let C = UInt8(self.significandBitPattern & 0xFF00000000     / 0x100000000)
        let D = UInt8(self.significandBitPattern & 0xFF000000       / 0x1000000)
        let E = UInt8(self.significandBitPattern & 0xFF0000         / 0x10000)
        let F = UInt8(self.significandBitPattern & 0xFF00           / 0x100)
        let G = UInt8(self.significandBitPattern & 0xFF             / 0x1)
        return (A: A, B: B, C: C, D: D, E: E, F: F, G: G)
    }
    
    // H I
    // H - содержит 3 бита информации
    // I - содержит 8 бит информации
    func getExponent() -> (H: UInt8, I: UInt8) {
        let H = UInt8(self.exponentBitPattern & 0xFF00 / 0x100)
        let I = UInt8(self.exponentBitPattern & 0xFF   / 0x1)
        return (H: H, I: I)
    }
    
    private func pad(_ string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<(toSize - string.count) {
            padded = "0" + padded
        }
        return padded
    }
    
    func getSignString() -> String {
        switch self.sign {
            case .plus: return "0"
            case .minus: return "1"
        }
    }
    
    func getExponentString() -> String {
        let (H, I) = self.getExponent()
        let h = pad(String(H, radix: 2), toSize: 3)
        let i = pad(String(I, radix: 2), toSize: 8)
        return "\(h) \(i)"
    }
    
    func getMantissaString() -> String {
        let (A, B, C, D, E, F, G) = self.getMantissa()
        let a = pad(String(A, radix: 2), toSize: 4)
        let b = pad(String(B, radix: 2), toSize: 8)
        let c = pad(String(C, radix: 2), toSize: 8)
        let d = pad(String(D, radix: 2), toSize: 8)
        let e = pad(String(E, radix: 2), toSize: 8)
        let f = pad(String(F, radix: 2), toSize: 8)
        let g = pad(String(G, radix: 2), toSize: 8)
        return "\(a) \(b) \(c) \(d) \(e) \(f) \(g)"
    }
    
    func getStringRepresentation() -> String {
        return "S: \(self.getSignString())  E: \(self.getExponentString())  M: \(self.getMantissaString())"
    }
    
}
