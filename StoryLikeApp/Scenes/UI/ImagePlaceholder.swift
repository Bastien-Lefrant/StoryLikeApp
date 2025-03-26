//
//  ImagePlaceholder.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI
import Lottie

struct ImagePlaceholder: View {

    private enum Constants {
        static let lottieSize: CGFloat = 150
    }

    var body: some View {
        ZStack {
            LottieView(animation: .named(Strings.Lotties.placeholderLoader))
                .playing(loopMode: .loop)
                .frame(width: Constants.lottieSize,
                       height: Constants.lottieSize)
        }
    }
}
