//
//  ErrorView.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 04/11/2024.
//

import SwiftUI
import Lottie

struct ErrorView: View {

    // MARK: Error Types
    enum ErrorType {
        case noResult
        case errorOccured
    }

    // MARK: Constants
    private enum Constants {
        static let lottieSize: CGFloat = 80
    }

    // MARK: Properties
    let type: ErrorType
    let message: String?

    private var viewConfig: (lottieName: String, messageColor: Color) {
        switch type {
        case .noResult: (Strings.Lotties.noResult, Color(.textPrimary))
        case .errorOccured: (Strings.Lotties.errorOccured, Color(.negative))
        }
    }

    // MARK: View
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                LottieView(animation: .named(viewConfig.lottieName))
                    .playing(loopMode: .loop)
                    .frame(width: Constants.lottieSize,
                           height: Constants.lottieSize)
                if let message {
                    Text(message)
                        .font(.body)
                        .foregroundStyle(viewConfig.messageColor)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
    }
}
