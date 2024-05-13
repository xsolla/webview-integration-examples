import SwiftUI

struct WKWebViewScreen: View {
    @State private var showWebView: Bool = false
    @State private var address = "https://secure.xsolla.com/paystation4?token=3gokr0iLa6ltL7JFLNgu9eXznE503iyS_lc_en_bg_FFFFFF_tb_64F53D"
    
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
