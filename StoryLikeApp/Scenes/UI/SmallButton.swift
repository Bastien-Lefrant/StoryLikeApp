//
//  SmallButton.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI

struct SmallButton: View {

    // MARK: Constants
    private enum Constants {
        static let imageSize: CGFloat = 25
        static let padding: CGFloat = 15
    }

    // MARK: Icons
    enum Icon: String {
        case close = "xmark"
        case like = "heart"
        case unlike = "heart.fill"
    }

    // MARK: Properties
    let icon: Icon
    let action: () -> Void

    var body: some View {
        Button(action: action,
               label: {
            Image(systemName: icon.rawValue)
                .frame(width: Constants.imageSize,
                       height: Constants.imageSize)
        })
        .padding(Constants.padding)
    }
}
