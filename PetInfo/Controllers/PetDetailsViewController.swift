//
//  PetDetailsViewController.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    
    lazy var loader = CustomLoaderView(text: "Loading...")
    var viewModel: PetDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        view.addSubview(loader)
        title = viewModel.petDetails?.title
        guard let url = URL(string: viewModel.petDetails?.contentUrl ?? "") else {
            return
        }
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
        loader.show()
    }
}

extension PetDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.hide()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.hide()
    }
}
