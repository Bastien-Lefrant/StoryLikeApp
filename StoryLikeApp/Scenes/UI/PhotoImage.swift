//
//  PhotoImage.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI
import NukeUI

struct PhotoImage: View {
    let url: URL?

    var body: some View {
        LazyImage(url: url,
                  transaction: Transaction(animation: .default)) { state in
            if let image = state.image {
                image.resizable().aspectRatio(contentMode: .fill)
            } else {
                ImagePlaceholder()
            }
        }
    }
}
