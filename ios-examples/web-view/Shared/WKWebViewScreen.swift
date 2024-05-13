import SwiftUI

struct WKWebViewScreen: View {
    @State private var action = WebViewAction.idle
    @State private var state = WebViewState.empty
    @State private var address = "https://secure.xsolla.com/paystation4?token=YOUR_TOKEN"
    
    var body: some View {
        VStack(spacing: 0) {
            navigationToolbar
            Divider()
            WebView(action: $action,
                    state: $state,
                    restrictedPages: ["apple.com"])
            Spacer()
        }
    }
  
    private var navigationToolbar: some View {
        HStack(spacing: 10) {
            TextField("Address", text: $address)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            
            if state.isLoading {
                if #available(iOS 14, macOS 10.15, *) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Text("Loading")
                }
            }
            Spacer()
            Button("Go") {
                if let url = URL(string: address) {
                    action = .load(URLRequest(url: url))
                }
            }
            Button(action: {
                action = .reload
            }) {
                Image(systemName: "arrow.counterclockwise")
                    .imageScale(.large)
            }
            if state.canGoBack {
                Button(action: {
                    action = .goBack
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                }
            }
            if state.canGoForward {
                Button(action: {
                    action = .goForward
                }) {
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    
                }
            }
        }.padding()
    }
}

struct WKWebViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WKWebViewScreen()
        }
    }
}
