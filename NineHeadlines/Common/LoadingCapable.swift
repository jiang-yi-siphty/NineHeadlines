//
//  LoadingCapable.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 12/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation
import UIKit

protocol LoadingCapable: class {
    
    func showLoadingView()
    func hideLoadingView()
    
}

extension LoadingCapable where Self: UIViewController {
    
    func showLoadingView() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    func hideLoadingView() {
        dismiss(animated: false, completion: nil)
    }
    
   
}
