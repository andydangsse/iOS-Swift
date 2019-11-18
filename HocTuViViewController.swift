//
//  HocTuViViewController.swift
//  TuVi
//
//  Created by Kahn on 4/2/17.
//  Copyright © 2017 Le Thanh Tan. All rights reserved.
//

import UIKit

class HocTuViViewController: BaseViewController {
    @IBOutlet weak var tuviWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: Constants.UrlIdentifier.urlHocTuVi) {
            let request = URLRequest(url: url)
            tuviWebView.loadRequest(request)
        }
        
        tuviWebView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RevmobHelper.share.showBanner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RevmobHelper.share.hideBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension HocTuViViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webview loading finish")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("webview fail to load")
    }
}
