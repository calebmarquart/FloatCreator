//
//  WebView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2022-08-25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
