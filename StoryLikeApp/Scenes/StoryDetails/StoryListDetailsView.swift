//
//  StoryListDetailsView.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI

struct StoryListDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Properties
    @State var viewModel: StoryListViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            PhotoImage(url: viewModel.selectedStory?.imageURLs.large)
                .aspectRatio(contentMode: .fit)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let hTranslation = value.translation.width
                            guard hTranslation != 0 else { return }
                            viewModel.selectNextStory(hTranslation < 0)
                        }
                )
        }
        .overlay(SmallButton(icon: .close,
                             action: { viewModel.selectedStory = nil }),
                 alignment: .topTrailing)
        .overlay(SmallButton(icon: (viewModel.selectedStory?.isLiked ?? false) ? .unlike : .like,
                             action: { viewModel.toggleSelectedStoryLiked() }),
                 alignment: .bottomTrailing)
    }
}
