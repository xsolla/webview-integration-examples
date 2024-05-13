import SwiftUI

struct ContentView: View {
    let views = ["WKWebView"]
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: WKWebViewScreen()) {
                    Text("WKWebView")
                }
            }
            .navigationBarTitle("WebView Solutions", displayMode: .inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
