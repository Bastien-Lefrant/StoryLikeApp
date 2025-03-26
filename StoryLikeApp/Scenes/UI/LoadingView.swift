//
//  LoadingView.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI
import Lottie

struct LoadingView: View {

    private enum Constants {
        static let lottieSize: CGFloat = 60
    }

    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            LottieView(animation: .named(Strings.Lotties.mainLoader))
                .playing(loopMode: .loop)
                .frame(width: Constants.lottieSize, height: Constants.lottieSize)
        }
    }
}
