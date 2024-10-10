//
//  UserGridView.swift
//  Assignment5
//
//  Created by Narek on 30.09.24.
//

import SwiftUI

struct UsersGridView: View {
    // MARK: - Properties

    @Binding var itemsCountInRow: Int
    var users: [User]
    var width: CGFloat
    var paddingHorizontal: CGFloat = 16
    var horizontalDistanceBetweenItems: CGFloat = 16
    var verticalDistanceBetweenItems: CGFloat = 32
    var onTapAction: (User) -> Void
    var loadMoreAction: () -> Void

    var rowCount: Int {
        return if users.count % itemsCountInRow == 0 {
            users.count / itemsCountInRow
        } else {
            users.count / itemsCountInRow + 1
        }
    }

    var realWidth: CGFloat {
        let paddingBetweenItems = CGFloat(itemsCountInRow - 1) * horizontalDistanceBetweenItems
        let padding = 2 * paddingHorizontal + paddingBetweenItems
        return (width - padding) / CGFloat(itemsCountInRow)
    }

    var realHeight: CGFloat {
        realWidth * 4 / 3
    }

    var columns: [GridItem] {
        var columns: [GridItem] = []
        for _ in 0 ..< itemsCountInRow {
            columns.append(GridItem(.fixed(realWidth), spacing: horizontalDistanceBetweenItems))
        }
        return columns
    }

    // MARK: - Body

    var body: some View {
        LazyVGrid(columns: columns, spacing: 32) {
            ForEach(users, id: \.self) { user in
                UserView(user: user, width: realWidth, height: realHeight)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        onTapAction(user)
                    }
                    .onAppear {
                        if user == users.last {
                            loadMoreAction()
                        }
                    }
            } //: LOOP
        } //: GRID
    }
}

// MARK: - Preview

#Preview {
    UsersGridView(
        itemsCountInRow: .constant(2),
        users: [],
        width: 300,
        onTapAction: { _ in },
        loadMoreAction: {}
    )
}
