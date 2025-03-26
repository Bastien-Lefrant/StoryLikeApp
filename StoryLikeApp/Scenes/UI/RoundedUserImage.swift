//
//  RoundedUserImage.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI
import NukeUI

struct RoundedUserImage: View {
    
    private enum Constants {
        static let size: CGFloat = 70
    }

    let url: URL?

    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image.resizable().aspectRatio(contentMode: .fill)
            } else {
                Color(.backgroundSecondary)
            }
        }
        .frame(width: Constants.size,
               height: Constants.size)
        .clipShape(.circle)
    }
}
