//
//  WebView.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import SwiftUI
import WebKit

// formatting, all nice things - this is horrendous but oh well
let HTML_HEADER_STRING_LIGHT_MODE = """
<header>
<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
</header>
<head>
    <style>
        :root {
            color-scheme: light;
            font-family: -apple-system;
        }
    </style>
</head>
"""

let HTML_HEADER_STRING_DARK_MODE = """
<header>
<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
</header>
<head>
    <style>
        :root {
            background-color: #1C1C1E;
            color-scheme: dark;
            font-family: -apple-system;
        }
    </style>
</head>
"""

// https://developer.apple.com/forums/thread/653935 - render HTML in SwiftUI
struct WebView: UIViewRepresentable {
    let text: String
    
    @Environment(\.colorScheme) var colorScheme
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(
            (colorScheme == .dark ? HTML_HEADER_STRING_DARK_MODE : HTML_HEADER_STRING_LIGHT_MODE) + text,
            baseURL: nil
        )
    }
}
