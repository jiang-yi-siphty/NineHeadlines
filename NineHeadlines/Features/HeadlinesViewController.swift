//
//  HeadlinesViewController.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController {

    private var tableView = UITableView()
    lazy var viewModel: HeadlinesViewModel = {
        return HeadlinesViewModel()
    }()
    
    //MARK: - Event
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
        prepareViewModel()
    }
    
    func prepareViewController() {
    }
    
    func prepareViewModel() {
    }

}
