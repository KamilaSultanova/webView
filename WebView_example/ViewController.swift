//
//  ViewController.swift
//  WebView_example
//
//  Created by Kamila Sultanova on 19.06.2024.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
    
    let forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: self, action: #selector(goForward))
           
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
    
    let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePage))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.isEnabled = false
        forwardButton.isEnabled = false
        toolbar.setItems([backButton, flexibleSpace, forwardButton, flexibleSpace, refreshButton, flexibleSpace, shareButton], animated: false)
        
        webView.navigationDelegate = self
        
        if let url = URL(string: "https://uis.unesco.org/en/home"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    @objc func goBack(){
        guard webView.canGoBack else { return }
            webView.goBack()
    }
    
    @objc func goForward(){
        guard webView.canGoForward else { return }
            webView.goForward()
    }
    
    @objc func refreshPage(){
        webView.reload()
    }

    @objc func sharePage(){
        let activityVC = UIActivityViewController(activityItems: [webView.url!], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)

    }
}

extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        backButton.isEnabled = false
        forwardButton.isEnabled = false
    
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
   
    }
}
