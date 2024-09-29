//
//  UIWindow+Ext.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import UIKit

extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}
