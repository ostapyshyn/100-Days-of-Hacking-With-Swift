//
//  DetailViewController.swift
//  Project7
//
//  Created by Volodymyr Ostapyshyn on 18.05.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h3>\(detailItem.title)</h3>
        <p>\(detailItem.body)</p>
        <p><strong> Signatures: \(detailItem.signatureCount)</strong></p>
        <p><a href="\(detailItem.url)" style="color: #007AFF; text-decoration: none">\(detailItem.url)</a></p>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    
}
