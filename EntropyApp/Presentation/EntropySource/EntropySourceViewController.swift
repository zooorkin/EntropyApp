//
//  EntropySourceViewController.swift
//  Entropy
//
//  Created by Андрей Зорькин on 08.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class EntropySourceViewController: UIViewController, IEntropySourceModelDelegate {

    @IBOutlet weak var sourceView: TouchView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var PearsonTestResultLabel: UILabel!
    @IBOutlet weak var countOfNumberSegmentedControl: UISegmentedControl!
    @IBOutlet weak var statisticsInformationLabel: UILabel!
    
    private let presentationAssembly: IPresentationAssembly

    private var model: IEntropySourceModel


    init(presentationAssembly: IPresentationAssembly, model: IEntropySourceModel) {
        self.presentationAssembly = presentationAssembly
        self.model = model
        super.init(nibName: "EntropySourceViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        sourceView.delegate = model
        switch model.source {
        case .Touches:
            break;
        default:
            sourceView.isUserInteractionEnabled = false
        }
        PearsonTestResultLabel.text = "Гипотеза о равномерном распределении..."
    }

    @IBAction func pearsonTestAction(_ sender: Any) {
        let prevText = PearsonTestResultLabel.text ?? ""
        PearsonTestResultLabel.text = prevText + " [Обновляется]"
        let count = Int(countOfNumberSegmentedControl
            .titleForSegment(at: countOfNumberSegmentedControl.selectedSegmentIndex)!
        )!
        model.requestRandomNumbers(count: count)
        
    }
    
    func entropySourceModelDidGetInformationFromSource(_ text: String) {
        DispatchQueue.main.async {
            self.informationLabel.text = text
        }
    }
    
    func entropySourceModelDidGetRandomNumbers(_ numbers: [UInt32]) {
        
    }
    
    func entropySourceModelDidGetRandomNumbers(_ numbers: [UInt16]) {

    }
    
    func entropySourceModelDidGetRawValues( _ values: [Double]) {
        var binary = ""
        var raw = ""
        for (index, i) in values.enumerated(){
            let prolog = "Значение #\(index)  "
            let epilog = "\n"
            binary += prolog + i.getStringRepresentation() + epilog
            raw += prolog + "\(i)" + epilog
        }
        DispatchQueue.main.async {
            self.informationLabel.text = binary + "\n" + raw
        }
    }
    
    func entropySourceModelDidGetRawValues(_ values: [Float]) {
        entropySourceModelDidGetRawValues(values.map({ (x) -> Double in Double(x) }))
    }
    
    func entropySourceModelDidGetPearsonTest(result: String) {
        DispatchQueue.main.async {
            self.PearsonTestResultLabel.text = result
        }
    }
    
    var expectation: String = "..."
    var realExpectation: String = "..."
    var varience: String = "..."
    var realVarience: String = "..."
    var expectationDiff: String = "..."
    var varienceDiff: String = "..."
    
    private func updateStatisticsInformation(){
        DispatchQueue.main.async {
            self.statisticsInformationLabel.text =
                "\(self.expectation) – выборочное среднее\n" +
                "\(self.realExpectation) - теоретическое среднее\n" +
                "\(self.varience) - выборочная дисперсия\n" +
                "\(self.realVarience) - теоретическая дисперсия\n" +
                "\(self.expectationDiff)% - смещение выборочного среднего\n" +
                "\(self.varienceDiff)% - смещение дисперсии"
        }
    }
    
    func entropySourceModelDidGetExpectation(result: String) {
        expectation = result
        updateStatisticsInformation()
    }
    
    func entropySourceModelDidGetRealExpectation(result: String) {
        realExpectation = result
        updateStatisticsInformation()
    }
    
    func entropySourceModelDidGetVarience(result: String) {
        varience = result
        updateStatisticsInformation()
    }
    
    func entropySourceModelDidGetRealVarience(result: String) {
        realVarience = result
        updateStatisticsInformation()
    }
    
    func entropySourceModelDidGetVarienceDiff(result: String) {
        varienceDiff = result
        updateStatisticsInformation()
    }
    
    func entropySourceModelDidGetExpectationDiff(result: String) {
        expectationDiff = result
        updateStatisticsInformation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if model.source == .Touches {
            model.touches(touches: touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if model.source == .Touches {
            model.touches(touches: touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if model.source == .Touches {
            model.touches(touches: touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if model.source == .Touches {
            model.touches(touches: touches, with: event)
        }
    }


}
