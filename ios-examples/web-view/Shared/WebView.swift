import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView

    var url: URL
    var webView: WKWebView
    
    init(url: URL) {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences = preferences
        
        // Google Pay button is check UA
        // if we remove (like Safari/604.1), Google SDK won't work. Strange Google behaviour
        configuration.applicationNameForUserAgent = "Xsolla/0.0.1 (like Safari/604.1)"

        self.url = url
        self.webView = WKWebView(frame: CGRect.zero, configuration: configuration)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        
        if #available(iOS 16.4, *) {
            // availabled from 16.4
            webView.isInspectable = true
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension WebView {
    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WebView
        private var webViews: [WKWebView]
        
        init(_ parent: WebView) {
            self.parent = parent
            self.webViews = []
        }
        
        /*! Creates a new web view.
         @param webView The web view invoking the delegate method.
         @param configuration The configuration to use when creating the new web
         view. This configuration is a copy of webView.configuration.
         @param navigationAction The navigation action causing the new web view to
         be created.
         @param windowFeatures Window features requested by the webpage.
         @result A new web view or nil.
         @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
         */
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            
            if navigationAction.targetFrame == nil {
                let popupWebView = WKWebView(frame: .zero, configuration: configuration)
                popupWebView.navigationDelegate = self
                popupWebView.uiDelegate = self
                
                if #available(iOS 16.4, *) {
                    // availabled from 16.4
                    popupWebView.isInspectable = true
                }
                
                parent.webView.addSubview(popupWebView)
                popupWebView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                    popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                    popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                    popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
                ])
                
                self.webViews.append(popupWebView)
                return popupWebView
            }
            
            return nil
        }
        
        /** Notifies your app that the DOM window object's close() method completed successfully.
          @param webView The web view invoking the delegate method.
          @discussion Your app should remove the web view from the view hierarchy and update
          the UI as needed, such as by closing the containing browser tab or window.
          */
        func webViewDidClose(_ webView: WKWebView) {
            webViews.last?.removeFromSuperview();
            webViews.removeLast()
        }
    }
}
