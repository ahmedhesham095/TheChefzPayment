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
    func threeDsVerifySuccess(ref: String)
    func closeTransactionById(Id: String)
}

class ThreeDsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var chefzLogo: UIImageView!
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
        if let image = UIImage(named: "ic_chefz_logo", in:Bundle(for:ThreeDsViewController.self), compatibleWith: nil) {
            chefzLogo.image = image
        }
    }

    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}

extension ThreeDsViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            if urlStr.contains("payment/checkout/success") {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: {
                        self.isVerfyCard ? self.delegate?.threeDsVerifySuccess(ref: self.merchantRef ?? "") : self.delegate?.threeDsSuccess()
                    })
                }
            }
            
            if urlStr.contains("payment/checkout/failed") {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: {
                        self.delegate?.closeTransactionById(Id: self.getQueryStringParameter(url: urlStr, param: "cko-session-id") ?? "")
                    })
                }
            }
            
        }
        decisionHandler(.allow)
    }
}
