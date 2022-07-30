//
//  ThreeDsViewController.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 18/07/2022.
//

import UIKit
import WebKit

protocol ThreeDsResult {
    func threeDsSuccess()
    func threeDsFail()
    func threeDsSuccess(ref: String)
    func threeDsFail(ref: String)
}

class ThreeDsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var threeDsURL: String?
    var delegate: ThreeDsResult?
    var isVerfyCard = false
    var merchantRef: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let threeDSUrl = threeDsURL , let url = URL(string: threeDSUrl) {
            webView.load(URLRequest(url: url))
        }
        webView.navigationDelegate = self
    }

}

extension ThreeDsViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            if urlStr.contains("payment/success") {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: {
                        self.isVerfyCard ? self.delegate?.threeDsSuccess(ref: self.merchantRef ?? "") : self.delegate?.threeDsSuccess()
                    })
                }
            }
            
            if urlStr.contains("payment/failed") {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: {
                        self.isVerfyCard ? self.delegate?.threeDsFail(ref: self.merchantRef ?? "") : self.delegate?.threeDsFail()
                    })
                }
            }
            
        }
        decisionHandler(.allow)
    }
}
