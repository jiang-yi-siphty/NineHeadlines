//
//  NewsWebViewController.swift
//  NineHeadlines
//
//  Created by Yi JIANG on 11/6/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {
    var url: URL?
    private var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }
    
}
