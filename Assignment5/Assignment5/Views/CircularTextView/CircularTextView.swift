//
//  CircularTextView.swift
//  Assignment5
//
//  Created by Narek on 10.10.24.
//

import SwiftUI

struct CircularTextView: View {
    // MARK: - PROPERTIES

    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false
    @State var textSizes: [Int: Double] = [:]
    
    var radius: Double
    var text: String
    var kerning: CGFloat = 5.0
    
    private var texts: [(offset: Int, element: Character)] {
        return Array(text.enumerated())
    }
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            ForEach(self.texts, id: \.self.offset) { offset, element in
                VStack {
                    Text(String(element))
                        .foregroundStyle(isDarkMode ? Color.white : Color.black)
                        .kerning(self.kerning)
                        .background(SizeableView())
                        .onPreferenceChange(WidthPreferenceKey.self) { size in
                            self.textSizes[offset] = Double(size)
                        }
                    Spacer()
                }
                .rotationEffect(self.angle(at: offset))
            }
        }
        .rotationEffect(-self.angle(at: self.texts.count - 1) / 2)
    }
    
    // MARK: - CALCULATE ANGLE
    
    private func angle(at index: Int) -> Angle {
        guard let labelSize = textSizes[index] else { return .radians(0) }
        let percentOfLabelInCircle = labelSize / radius.perimeter
        let labelAngle = 2 * Double.pi * percentOfLabelInCircle
        
        let totalSizeOfPreChars = textSizes.filter { $0.key < index }.map { $0.value }.reduce(0, +)
        let percenOfPreCharInCircle = totalSizeOfPreChars / radius.perimeter
        let angleForPreChars = 2 * Double.pi * percenOfPreCharInCircle
        
        return .radians(angleForPreChars + labelAngle)
    }
}
