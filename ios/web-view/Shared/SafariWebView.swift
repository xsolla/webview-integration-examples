import SwiftUI
import SafariServices

struct UIViewControllerView: UIViewControllerRepresentable {
    final class ViewController: UIViewController {
        var didAppear: (UIViewController) -> Void = { _ in }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            didAppear(self)
        }
    }

    var didAppear: (UIViewController) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ViewController()
        viewController.didAppear = didAppear
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
    }
}

struct UIViewControllerViewModifier: ViewModifier {
    var didAppear: (UIViewController) -> Void
    var viewControllerView: some View {
        UIViewControllerView(didAppear:didAppear).frame(width:0,height:0)
    }
    func body(content: Content) -> some View {
        content.background(viewControllerView)
    }
}

extension View {
    func uiViewController(didAppear: @escaping (UIViewController) -> ()) -> some View {
        modifier(UIViewControllerViewModifier(didAppear:didAppear))
    }
}

class HostingObject<Content: View>: ObservableObject {
    @Published var viewController: UIViewController? = nil
}

struct HostingObjectView<Content: View>: View {
    var rootView: Content
    let hostedObject = HostingObject<Content>()
    func getHost(viewController: UIViewController) {
        hostedObject.viewController = viewController.parent
    }
    var body: some View {
        rootView
            .uiViewController(didAppear: getHost(viewController:))
            .environmentObject(hostedObject)
    }
}

protocol Hostable: View {
    associatedtype Content: View
    func hosting() -> Content
}

extension Hostable {
    func hosting() -> some View {
        HostingObjectView(rootView: self)
    }
}

struct SafariWebView: View {
    struct RootView: View, Hostable {
        @EnvironmentObject private var hostedObject: HostingObject<Self>
        @State private var address = "https://developers.google.com/pay/api/web/guides/resources/demos?hl=ru"
    
        var body: some View {
            VStack {
                navigationToolbar
                Spacer()
            }
        }
    
        private var navigationToolbar: some View {
            HStack(spacing: 10) {
                TextField("Address", text: $address)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
        
                Spacer()
                Button("Go") {
                    if let url = URL(string: address) {
                        openSafariWebView(url: url)
                    }
                    
                }
            }.padding()
        }
    
        private func openSafariWebView(url: URL) {
            let controller = SFSafariViewController(url: url)
            
            hostedObject.viewController?.present(controller, animated: true)
        }
    }
    
    var body: some View {
        RootView().hosting()
    }
}

struct SafariWebView_Previews: PreviewProvider {
    static var previews: some View {
        SafariWebView()
    }
}
