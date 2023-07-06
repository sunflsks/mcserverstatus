//
//  WebView.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import SwiftUI
import WebKit

// formatting, all nice things
let HTML_HEADER_STRING = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header> <head> <style> body { font-family: -apple-system } </style>"

// https://developer.apple.com/forums/thread/653935 - render HTML in SwiftUI
struct WebView: UIViewRepresentable {
    let text: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(HTML_HEADER_STRING + text, baseURL: nil)
    }
}
