//
//  Console.swift
//  Assignment5
//
//  Created by Narek on 29.09.24.
//

import os
import UIKit

struct Console {
    private init() {}

    static func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        let output = items.map { "🔓\n\($0)" }.joined(separator: separator)
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Assignment5", category: "custom_console_logger")
        logger.log("This is a log message with a value: \(output)")
    }
}
