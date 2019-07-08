//
//  EntropySourcesListViewController.swift
//  Entropy
//
//  Created by Андрей Зорькин on 01.07.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class EntropySourcesListViewController: UITableViewController, IEntropySourcesListModelDelegate {

    private let presentationAssembly: IPresentationAssembly
    
    private var model: IEntropySourcesListModel
    

    init(presentationAssembly: IPresentationAssembly, model: IEntropySourcesListModel) {
        self.presentationAssembly = presentationAssembly
        self.model = model
        super.init(nibName: "EntropySourcesListViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: "EntropyListCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "EntropyListCell")
        title = "Источники энтропии"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        model.delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "EntropyListCell")
        cell.textLabel?.text = model.sourceEntropyName(at: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let source = model.sourceEntropy(at: indexPath.row)
        let entropySourceViewController = presentationAssembly.entropySourceViewController(source: source)
            entropySourceViewController.title = model.sourceEntropyName(at: indexPath.row)
            self.navigationController?.pushViewController(entropySourceViewController, animated: true)
    }

}
