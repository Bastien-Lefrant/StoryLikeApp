//
//  ErrorView.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI
import Lottie

struct ErrorView: View {

    // MARK: Constants
    private enum Constants {
        static let lottieSize: CGFloat = 80
    }

    // MARK: Properties
    let message: String?

    // MARK: View
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                LottieView(animation: .named(Strings.Lotties.errorOccured))
                    .playing(loopMode: .loop)
                    .frame(width: Constants.lottieSize,
                           height: Constants.lottieSize)
                if let message {
                    Text(message)
                        .font(.body)
                        .foregroundStyle(Color(.negative))
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
    }
}
