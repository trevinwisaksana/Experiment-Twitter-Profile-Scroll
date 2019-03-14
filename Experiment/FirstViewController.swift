//
//  FirstViewController.swift
//  Experiment
//
//  Created by Stockbit on 12/03/19.
//  Copyright © 2019 Stockbit. All rights reserved.
//

import UIKit
import Parchment

final class FirstViewController: FixedPagingViewController {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(viewControllers: [UIViewController]) {
        super.init(viewControllers: viewControllers)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
    
}
