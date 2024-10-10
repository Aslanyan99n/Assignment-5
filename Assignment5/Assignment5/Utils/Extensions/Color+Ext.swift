//
//  Color+Ext.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import SwiftUI

extension Color {
    var uiColor: UIColor {
        return UIColor(self)
    }
}

// MARK: - New Colors

extension Color {
    enum Surface {
        static let surface10 = Color(hex: "#FFFFFF")
        static let surface20 = Color(hex: "#F6F6F6")
        static let skeletonStart = Color(hex: "#FAFAFA")
        static let skeletonEnd = Color(hex: "#D3D3D3") // "#F0F0F0")
    }
    
    enum Divider {
        static let divider10 = Color(hex: "#F2F2F2")
        static let divider50 = Color(hex: "#E7E7E7")
        static let divider100 = Color(hex: "#D1D1D6")
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let aaa, rrr, ggg, bbb: UInt64

        switch hex.count {
        case 6:
            (rrr, ggg, bbb, aaa) = (
                (int & 0xFF0000) >> 16,
                (int & 0x00FF00) >> 8,
                int & 0x0000FF,
                255
            )
        case 8:
            (rrr, ggg, bbb, aaa) = (
                (int & 0xFF000000) >> 24,
                (int & 0x00FF0000) >> 16,
                (int & 0x0000FF00) >> 8,
                int & 0x000000FF
            )
        default:
            (rrr, ggg, bbb, aaa) = (1, 1, 0, 1)
        }

        self.init(
            .sRGB,
            red: Double(rrr) / 255.0,
            green: Double(ggg) / 255.0,
            blue: Double(bbb) / 255.0,
            opacity: Double(aaa) / 255.0
        )
    }
}

extension UIColor {
    convenience init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let aaa, rrr, ggg, bbb: UInt64
        
        switch hex.count {
        case 6:
            (rrr, ggg, bbb, aaa) = (
                (int & 0xFF0000) >> 16,
                (int & 0x00FF00) >> 8,
                int & 0x0000FF,
                255
            )
        case 8:
            (rrr, ggg, bbb, aaa) = (
                (int & 0xFF000000) >> 24,
                (int & 0x00FF0000) >> 16,
                (int & 0x0000FF00) >> 8,
                int & 0x000000FF
            )
        default:
            (rrr, ggg, bbb, aaa) = (1, 1, 0, 1)
        }

        self.init(red: Double(rrr) / 255.0,
                  green: Double(ggg) / 255.0,
                  blue: Double(bbb) / 255.0,
                  alpha: Double(aaa) / 255.0)
    }
}

extension Color {
    var colorToHex: String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)

        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
