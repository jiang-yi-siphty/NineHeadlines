//
//  HeadlinesViewController.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 10/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

/*
 Comment: 
 In this ViewController, I am not using Storyboard or Xib to build the UI to showoff my programmatic UI development skill. However, I will use Xib to build the TableViewCell to showoff my autolayout skill in interface builder.
 */
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
        prepareTableView()
    }
    
    func prepareViewController() {
        title = "Nine Headlines"
    }
    
    func prepareViewModel() {
        viewModel.updated = { 
            DispatchQueue.main.async { [weak self] in
            	self?.tableView.reloadData()
            }
        }
        
        viewModel.hasAlertMessage = { (message, _) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(message)
            }
        }
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: .tableViewCellID, bundle: nil), 
                           forCellReuseIdentifier: .tableViewCellID)
        tableView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) 
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        tableView.reloadData()
        tableView.estimatedRowHeight = 144.0
        tableView.rowHeight = UITableView.automaticDimension 
    }
    
    // MARK: - private func
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: .alertTitleText, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: .alertButtonText, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - TableView
extension HeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
   
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: .tableViewCellID, for: indexPath) as? HeadlineTableViewCell{
            return cell
        }
        fatalError("Failed to locate a cell with ReusableCell Identifier: " + .tableViewCellID)
    }
    
    func tableView(_ tableView: UITableView, 
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, 
                   didSelectRowAt indexPath: IndexPath) {
//        guard let url = viewModel.url(at: indexPath) else { return }
//        let newsWebViewController = NewsWebViewController()
//        newsWebViewController.url = url
//        let navigationWrapper = UINavigationController(rootViewController: newsWebViewController)
//        navigationController?.present(navigationWrapper, animated: true, completion: nil)
//        present(newsWebViewController, animated: true, completion: nil)
    }
}

fileprivate extension String {
    static let alertTitleText = "Alert"
    static let alertButtonText = "OK"
    static let tableViewCellID = "HeadlineTableViewCell"
}
