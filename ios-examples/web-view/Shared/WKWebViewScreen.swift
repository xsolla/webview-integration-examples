import SwiftUI

struct WKWebViewScreen: View {
    @State private var showWebView: Bool = false
    @State private var address = "https://secure.xsolla.com/paystation4?token=YOUR_TOKEN"
    
    var body: some View {
        VStack {
            Button {
                showWebView.toggle()
            } label: {
                Text("Open web view")
            }
            .sheet(isPresented: $showWebView, content: {
                WebView(url: URL(string: address)!)
            })
        }
     
    }
}

struct WKWebViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        WKWebViewScreen()
    }
}
