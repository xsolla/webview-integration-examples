## Description
This is the basic WebView implementation that partners are likely to have. There is no separate logic to support popups in it

Currently, we support this webview solutions:
* SafariViewController
* WKWebView

## Launch
The launch is carried out via Cradle.

You can setup url in:
* Shared/SafariWebView.swift - Line 80 `@State private var address = "http://localhost:3000/?access_token=9ns99WkR46MVGifhBBsy4SZG4WAPFHJM__default_dark"`
* Shared/WKWebViewScreen.swift - Line 13 `@State private var address = "https://ps4-live-demo--preview-b1m6x4bu.web.app""`
