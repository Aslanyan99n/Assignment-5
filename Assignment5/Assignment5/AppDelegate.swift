//
//  AppDelegate.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import Foundation
import UIKit
import PulseProxy
import Pulse

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Console.log("Starting...")
        return true
    }
    
    private func setupNetworkLogger() {
        #if DEBUG
        URLSessionProxyDelegate.enableAutomaticRegistration()
        NetworkLogger.enableProxy()
        RemoteLogger.shared.isAutomaticConnectionEnabled = true
        #endif
    }
}
