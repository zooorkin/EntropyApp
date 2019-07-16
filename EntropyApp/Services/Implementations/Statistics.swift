//
//  Statistics.swift
//  EntropyApp
//
//  Created by Андрей Зорькин on 15/07/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

class Statistics {
    
    public func expectationDiff(expectation: UInt32, realExpectation: UInt32) -> Double {
        var a = expectation
        var b = realExpectation
        if a < b {
            swap(&a, &b)
        }
        let c = realExpectation
        return Double((a - b)) / Double(c) * 100
    }
    
    public func varienceDiff(varience: UInt64, realVarience: UInt64) -> Double {
        var a = varience
        var b = realVarience
        if a < b {
            swap(&a, &b)
        }
        let c = realVarience
        return Double((a - b)) / Double(c) * 100
    }
    
    public func realExpectation() -> UInt32 {
        return UInt32.max / 2
    }
    
    public func realVarience() -> UInt64 {
        let x = UInt64(UInt32.max / 2)
        return x / 3 * x
    }
    
    public func expectation(numbers: [UInt32]) -> UInt32 {
        return UInt32(numbers.reduce(0) { (sum: UInt64, x: UInt32) -> UInt64 in
             sum + UInt64(x)
        } / UInt64(numbers.count))
    }
    
    public func varience(numbers: [UInt32], expectation: UInt32) -> UInt64 {
        let sum = numbers.reduce(0) { (sum: UInt64, x: UInt32) -> UInt64 in
            let diff = abs(Int64(x) - Int64(expectation))
            return sum + (UInt64(diff) / UInt64(numbers.count - 1) * UInt64(diff))
        }
        return sum
    }
    
    public func pearsonTest(numbers: [UInt32], k: Int = 10) -> String{
        let N = numbers.count
        let expectedFrequency = N / k
        assert(N % k == 0)
        assert(N/k > 5)
        let sortedNumbers = numbers.sorted()
        var realFrequencies = [Int](repeating: 0, count: k)
        
        var currentK: Int = 0;
        
        var bound = Double(UInt32.max) / Double(k)
        for number in sortedNumbers {
            while Double(number) > bound {
                currentK += 1
                bound = Double(UInt32.max) / Double(k) * Double(currentK + 1)
            }
            realFrequencies[Int(currentK)] += 1
        }
        var sum: Int = 0
        for realFrequency in realFrequencies {
            let diff = realFrequency - expectedFrequency
            sum += diff * diff
        }
        let calculatedXi = Double(sum) / Double(expectedFrequency)
        
        //print("XI^2 = \(calculatedXi)")
        switch k {
        case 10:
            return isRejected(calculatedXi, xi: 16.919)
        case 20:
            return isRejected(calculatedXi, xi: 30.144)
        default:
            fatalError()
        }
    }
    func isRejected(_ colculatedXi: Double, xi: Double) -> String {
        if colculatedXi > xi {
            return "ОТКЛОНЕНА"
            //return "H0 is rejected"
        } else {
            return "НЕ ОТКЛОНЕНА"
            //return "H0 is not rejected"
        }
    }
}
