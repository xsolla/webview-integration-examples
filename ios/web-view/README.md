## Description
This is the basic WebView implementation that partners are likely to have. 
In WKWebView solution we can handle popups.

Currently, we support this webview solutions:
* SafariViewController
* WKWebView

## Install
At first step we should install deps for this project, for this we using [cocoapods](https://cocoapods.org). Please install it, after that just run `pod install`.


## WebView setup
You can setup url in:
* Shared/SafariWebView.swift - Line 73 `@State private var address = "https://secure.xsolla.com/paystation4?token=u3ohA1skYQcMez53QRijxyB6B58xjDuh_lc_en"`
* Shared/WKWebViewScreen.swift - Line 6 `@State private var address = "https://secure.xsolla.com/paystation4?token=3gokr0iLa6ltL7JFLNgu9eXznE503iyS_lc_en_bg_FFFFFF_tb_64F53D"`
