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
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
        webView.uiDelegate = self
        return webView
    }()

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
        showLoadingView()
        webView.load(URLRequest(url: url))
    }
    
}

extension NewsWebViewController: WKNavigationDelegate, WKUIDelegate, LoadingCapable {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) 
    {
        hideLoadingView()
    }
    
}
