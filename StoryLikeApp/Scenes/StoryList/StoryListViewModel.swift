//
//  StoryListViewModel.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import Foundation
import Observation
import Factory

@Observable
final class StoryListViewModel {

    // MARK: States
    enum LoadingState: Equatable {
        case loading
        case failure(HTTPRequestService.RequestError?)
        case success
    }

    // MARK: Properties
    var loadingState: LoadingState
    var searchText: String
    var photos: [Photo]

    var filteredPhotos: [Photo] {
        photos.filter {
            guard !searchText.isEmpty else { return true }

            let photoStrings = [
                $0.user.username,
                $0.description,
                $0.slug
            ].compactMap { $0?.lowercased() }
            let lowercasedSearchText = searchText.lowercased()

            return photoStrings.contains { $0.contains(lowercasedSearchText) }
        }
    }

    // MARK: DI
    @Injected(\.photosRepository) @ObservationIgnored private var photosRepository

    // MARK: Init
    init(loadingState: LoadingState = .loading,
         searchText: String = "",
         photos: [Photo] = []) {
        self.loadingState = loadingState
        self.searchText = searchText
        self.photos = photos
    }

    // MARK: Public Methods
    func loadPhotos() async {
        loadingState = .loading
        do {
            try await Task.sleep(for: .seconds(4))
            let photos = try await photosRepository.fetchPhotos()

            self.photos = photos
            loadingState = .success
        } catch {
            photos.removeAll()
            loadingState = .failure(error as? HTTPRequestService.RequestError)
        }
    }
}
