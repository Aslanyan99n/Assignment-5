//
//  Assignment5App.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import SwiftUI

@main
struct Assignment5App: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            UsersScreen()
        }
    }
}
