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
