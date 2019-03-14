//
//  SecondViewController.swift
//  Experiment
//
//  Created by Stockbit on 12/03/19.
//  Copyright © 2019 Stockbit. All rights reserved.
//

import UIKit

protocol ViewControllerScrollableDelegate: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    weak var scrollDelegate: ViewControllerScrollableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = UITableViewCell()
        tableViewCell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        tableViewCell.backgroundColor = .green
        
        let label = UILabel(frame: tableViewCell.frame)
        label.textAlignment = .center
        label.center = tableViewCell.center
        label.text = "\(indexPath.row)"
        
        tableViewCell.addSubview(label)
        
        return tableViewCell
    }
}

extension SecondViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
}
