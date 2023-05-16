//
//  AppDelegate.swift
//  WebRTC
//
//  Created by kent.sun on 2023/5/15.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    private let config = Config.default
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.buildMainViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private func buildMainViewController() -> UIViewController {
        
        let webRTCClient = WebRTCClient(iceServers: self.config.webRTCIceServers)
        let signalClient = self.buildSignalingClient()
        let mainViewController = MainViewController(signalClient: signalClient, webRTCClient: webRTCClient)
        let navViewController = UINavigationController(rootViewController: mainViewController)
        navViewController.navigationBar.prefersLargeTitles = true
        return navViewController
    }
    
    private func buildSignalingClient() -> SignalingClient {
        
        // iOS 13 has native websocket support. For iOS 12 or lower we will use 3rd party library.
        let webSocketProvider: WebSocketProvider
        
        if #available(iOS 13.0, *) {
            webSocketProvider = NativeWebSocket(url: self.config.signalingServerUrl)
        } else {
            webSocketProvider = StarscreamWebSocket(url: self.config.signalingServerUrl)
        }
        
        return SignalingClient(webSocket: webSocketProvider)
    }
}

