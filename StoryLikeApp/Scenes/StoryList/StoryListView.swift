//
//  StoryListView.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI

struct PhotosListView: View {

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
            .navigationTitle(Strings.PhotosListView.home)
        }
        .tint(Color(.textTertiary))
        .foregroundStyle(Color(.textPrimary))
        .task {
            await viewModel.loadPhotos()
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
            ErrorView(type: .errorOccured,
                      message: error?.description)
        }
    }

    @ViewBuilder
    private var listView: some View {
        GeometryReader { geometry in
            List(viewModel.filteredPhotos) { photo in
                PhotosListCell(photo: photo,
                               containerWidth: geometry.size.width)
                    .overlay {
                        NavigationLink(destination: PhotoDetailsView(viewModel: .init(photo: photo))) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .overlay {
                if viewModel.filteredPhotos.isEmpty, !viewModel.searchText.isEmpty {
                    ErrorView(type: .noResult,
                              message: "\(Strings.PhotosListView.noResultMessage) \(viewModel.searchText)")
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .searchable(text: $viewModel.searchText)
            .animation(.default, value: viewModel.filteredPhotos)
        }
    }
}
