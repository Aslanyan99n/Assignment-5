//
//  Optional+Ext.swift
//  Assignment5
//
//  Created by Narek on 10.10.24.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
    var isNotNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
    public var isNotNil: Bool { !isNil }
}
