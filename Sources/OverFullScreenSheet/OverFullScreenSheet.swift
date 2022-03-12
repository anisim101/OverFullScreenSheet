
#if !os(macOS)
import SwiftUI
import UIKit

fileprivate var currentOverCurrentContextUIHost: UIViewController?
@available(iOS 13.0, *)
extension View {
    
    public func overFullScreenSheet<Content: View>(
        isPresented: Binding<Bool>,
        animated: Bool = true,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        onClose: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View {
        showIfNeeeded(isPresented: isPresented,
                      animated: animated,
                      transitionStyle: transitionStyle,
                      onClose: onClose, content: content)
        return self
    }
    
    public func overFullScreenSheet<Content: View,
                                    Item: Identifiable>
    (
        item: Binding<Item?>,
        animated: Bool = true,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        onClose: (() -> Void)? = nil,
        @ViewBuilder content: (Item) -> Content
    ) -> some View {
        
        showIfNedded(item: item,
                     content: content,
                     animated: animated,
                     transitionStyle: transitionStyle,
                     onClose: onClose)
        
        return self
    }
    
    private func showIfNeeeded<Content: View>(
        isPresented: Binding<Bool>,
        animated: Bool = true,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        onClose: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        if isPresented.wrappedValue  {
            if currentOverCurrentContextUIHost == nil {
                let uiHost = UIHostingController(rootView: content())
                currentOverCurrentContextUIHost = uiHost
                uiHost.modalPresentationStyle = .overFullScreen
                uiHost.modalTransitionStyle = transitionStyle
                uiHost.view.backgroundColor = UIColor.clear
                let rootVC = UIApplication.shared.windows.first?.rootViewController
                rootVC?.present(uiHost, animated: animated, completion: nil)
            }
        } else {
            if let uiHost = currentOverCurrentContextUIHost {
                uiHost.dismiss(animated: animated) {
                    onClose?()
                }
                currentOverCurrentContextUIHost = nil
            }
        }
    }
    
    private func showIfNedded<Content: View,
                              Item: Identifiable>
    (item: Binding<Item?>,
     content: (Item) -> Content,
     animated: Bool,
     transitionStyle: UIModalTransitionStyle,
     onClose: (() -> Void)?) {
        if let uiHost = currentOverCurrentContextUIHost {
            if let item = item.wrappedValue {
                let newHost = UIHostingController(rootView: content(item))
                uiHost.dismiss(animated: animated) {
                    currentOverCurrentContextUIHost = uiHost
                    newHost.modalPresentationStyle = .overFullScreen
                    newHost.modalTransitionStyle = transitionStyle
                    newHost.view.backgroundColor = UIColor.clear
                    let rootVC = UIApplication.shared.windows.first?.rootViewController
                    rootVC?.present(newHost, animated: animated, completion: nil)
                }
            } else {
                uiHost.dismiss(animated: animated) {
                    onClose?()
                }
            }
        } else {
            if let item = item.wrappedValue {
                let uiHost = UIHostingController(rootView: content(item))
                currentOverCurrentContextUIHost = uiHost
                uiHost.modalPresentationStyle = .overFullScreen
                uiHost.modalTransitionStyle = transitionStyle
                uiHost.view.backgroundColor = UIColor.clear
                let rootVC = UIApplication.shared.windows.first?.rootViewController
                rootVC?.present(uiHost, animated: animated, completion: nil)
            }
        }
    }
}

#endif
