//
//  Statistics.swift
//  EntropyApp
//
//  Created by Андрей Зорькин on 15/07/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

class Statistics {
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
            return "Гипотеза о равномерном распределении ОТКЛОНЕНА"
            //return "H0 is rejected"
        } else {
            return "Гипотеза о равномерном распределении НЕ ОТКЛОНЕНА"
            //return "H0 is not rejected"
        }
    }
}
