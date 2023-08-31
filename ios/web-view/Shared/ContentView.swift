//
//  ContentView.swift
//  Shared
//
//  Created by ni.poluhin on 01.07.2022.
//

import SwiftUI

struct ContentView: View {
    let views = ["WKWebView", "SafariViewController"]
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: WKWebViewScreen()) {
                    Text("WKWebView")
                }
                NavigationLink(destination: SafariWebView()) {
                    Text("SafariViewController")
                }
            }
            .navigationBarTitle("WebView Solutions")
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
