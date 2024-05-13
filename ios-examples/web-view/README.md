## Description
This is the basic WebView implementation that partners are likely to have. 
In WKWebView solution we can handle popups.

Currently, we support this webview solutions:
* WKWebView

## Install
At first step we should install deps for this project, for this we using [cocoapods](https://cocoapods.org). Please install it, after that just run `pod install`.


## WebView setup
You can setup url in:
* Shared/WKWebViewScreen.swift - Line 6 `@State private var address = "https://secure.xsolla.com/paystation4?token=YOUR_TOKEN"`. Replace YOUR_TOKEN with actual payment token
