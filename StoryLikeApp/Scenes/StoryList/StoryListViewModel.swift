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
    var stories: [Story]

    // MARK: DI
    @Injected(\.storiesRepository) @ObservationIgnored private var storiesRepository

    // MARK: Init
    init(loadingState: LoadingState = .loading,
         stories: [Story] = []) {
        self.loadingState = loadingState
        self.stories = stories
    }

    // MARK: Public Methods
    func loadStories() async {
        loadingState = .loading
        do {
            try await Task.sleep(for: .seconds(4))
            stories = try await storiesRepository.fetchStories()
            loadingState = .success
        } catch {
            stories.removeAll()
            loadingState = .failure(error as? HTTPRequestService.RequestError)
        }
    }
}
