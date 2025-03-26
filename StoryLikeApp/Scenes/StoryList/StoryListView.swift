//
//  StoryListView.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI

struct StoryListView: View {
    
    // MARK: Constants
    private enum Constants {
        static let storyListHeight: CGFloat = 150
    }

    // MARK: Properties
    @State var viewModel: StoryListViewModel

    // MARK: Views
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).ignoresSafeArea()
                contentView
            }
            .animation(.default, value: viewModel.loadingState)
            .navigationTitle(Strings.StoryListView.home)
        }
        .tint(Color(.textTertiary))
        .foregroundStyle(Color(.textPrimary))
        .task {
            await viewModel.loadStories()
        }
        .fullScreenCover(isPresented: $viewModel.showStoryListDetailsView) {
            StoryListDetailsView(viewModel: viewModel)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.loadingState {
        case .loading:
            LoadingView()
        case .success:
            listView
        case .failure(let error):
            ErrorView(message: error?.description)
        }
    }

    @ViewBuilder
    private var listView: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top) {
                    ForEach(viewModel.stories, id: \.self) { story in
                        StoryListCell(story: story)
                            .onAppear { viewModel.storyDidAppear(story) }
                            .onTapGesture {
                                viewModel.selectedStory = story
                            }
                    }
                }
                .padding()
            }
            .frame(height: Constants.storyListHeight)
            Spacer()
        }
    }
}

#Preview {
    StoryListView(viewModel: StoryListViewModel())
}
