//
//  ViewController.swift
//  Experiment
//
//  Created by Stockbit on 12/03/19.
//  Copyright © 2019 Stockbit. All rights reserved.
//

import UIKit
import Parchment

final class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentView: UIView!
    
    // At this offset the Header stops its transformations
    private lazy var offset_HeaderViewStop: CGFloat = headerView.frame.height
    private lazy var offset_ContentViewStop: CGFloat = view.frame.height
    
    lazy var firstViewController: FirstViewController = {
        let controller = FirstViewController(viewControllers: [])
        return controller
    }()
    
    lazy var secondViewController: SecondViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        controller.scrollDelegate = self
        
        return controller
    }()
    
    lazy var pagingViewController: FixedPagingViewController = {
        let controller = FixedPagingViewController(viewControllers: [secondViewController])
        controller.menuItemSize = PagingMenuItemSize.fixed(width: 0, height: 0)
        controller.collectionView.isHidden = true
        return controller
    }()
    
    private var lastContentOffset: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupPagingViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupTableViews()
    }
    
    private func setupPagingViewController() {
        contentView.addSubview(pagingViewController.view)
        pagingViewController.view.frame = contentView.bounds
        pagingViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pagingViewController.didMove(toParent: self)
    }
    
    private func setupTableViews() {
        secondViewController.tableView.contentInset = UIEdgeInsets(top: headerView.frame.height + segmentView.frame.height, left: 0, bottom: 0, right: 0)
        secondViewController.tableView.contentOffset = CGPoint(x: 0, y: -headerView.frame.height - segmentView.frame.height)
    }

}

extension ViewController: ViewControllerScrollableDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        var headerViewTransform = CATransform3DIdentity
        var segmentTransform = CATransform3DIdentity
        
        // PULL DOWN
        
        if offset > 0 {
            headerViewTransform = CATransform3DTranslate(headerViewTransform, 0, max(-offset_HeaderViewStop, -offset), 0)
            
            // Scroll the segment view until its offset reaches the same offset at which the header stopped shrinking
            segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(-offset_HeaderViewStop, -offset), 0)
            segmentView.layer.transform = segmentTransform
        }
        
        print("Offset: \(-offset)")
        print("Segment View: \(segmentView.frame.origin.y)")
        
        headerView.layer.transform = headerViewTransform
    }
}
