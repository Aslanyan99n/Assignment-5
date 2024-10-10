//
//  UserInfoRow.swift
//  Assignment5
//
//  Created by Narek on 09.10.24.
//

import SwiftUI

struct UserInfoRow: View {
    enum UserInfoType {
        case gender, location, phoneNumber, email

        var title: String {
            switch self {
            case .gender: String.Text.gender
            case .location: String.Text.location
            case .phoneNumber: String.Text.phoneNumber
            case .email: String.Text.email
            }
        }

        var icon: Image {
            switch self {
            case .gender: Image(systemName: "person.crop.circle.fill.badge.questionmark.ar")
            case .location: Image(systemName: "mappin.and.ellipse")
            case .phoneNumber: Image(systemName: "phone")
            case .email: Image(systemName: "envelope")
            }
        }
    }
    
    // MARK: - PROPERTIES
    
    @AppStorage(String.Text.isDarkMode) var isDarkMode: Bool = false

    var infoType: UserInfoType = .gender
    var info: String
    var hasDiveder: Bool = true
    
    // MARK: - BODY

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                infoType.icon
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.black)

                Spacer().frame(width: 4)

                Text(infoType.title)
                    .foregroundStyle(Color.gray)
                    .font(.headline)

                Spacer()

                Text(info)
                    .foregroundStyle(isDarkMode ? Color.white : Color.black)
                    .font(.body)
                    .if(infoType == .phoneNumber) { view in
                        view
                            .underline()
                            .onTapGesture {
                                if let url = URL(string: "tel://\(info)") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                    .if(infoType == .email) { view in
                        view
                            .underline()
                            .onTapGesture {
                                if let url = URL(string: "mailto:\(info)") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
            } //: HSTACK
            .padding(.vertical, 6)
            if hasDiveder {
                Divider()
                    .overlay { Color.gray.opacity(0.4) }
                    .frame(height: 0.5)
            }
        } //: VSTACK
    }
}
