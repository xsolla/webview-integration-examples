//
//  ContentView.swift
//  Shared
//
//  Created by ni.poluhin on 01.07.2022.
//

import SwiftUI

struct WKWebViewScreen: View {
    @State private var action = WebViewAction.idle
    @State private var state = WebViewState.empty
    @State private var address = "https://ps4-live-demo--preview-b1m6x4bu.web.app"
    
    var body: some View {
        VStack {
            titleView
            navigationToolbar
            errorView
            Divider()
            WebView(action: $action,
                    state: $state,
                    restrictedPages: ["apple.com"])
            Spacer()
        }
    }
    
    private var titleView: some View {
        Text(String(format: "%@", state.pageTitle ?? "Load a page", state.pageURL ?? "No URL"))
            .font(.system(size: 14))
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
    
    private var errorView: some View {
        Group {
            if let error = state.error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
    }
}

struct WKWebViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WKWebViewScreen()
        }
    }
}
