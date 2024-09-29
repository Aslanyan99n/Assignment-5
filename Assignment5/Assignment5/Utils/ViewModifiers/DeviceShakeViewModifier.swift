//
//  DeviceShakeViewModifier.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import SwiftUI

struct DeviceShakeViewModifier: ViewModifier {
    // MARK: - Properties

    let action: () -> Void

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}
