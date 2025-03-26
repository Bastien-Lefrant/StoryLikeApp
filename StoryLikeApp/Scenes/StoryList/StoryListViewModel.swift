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
    var selectedStory: Story? {
        didSet {
            showStoryListDetailsView = selectedStory != nil
        }
    }
    var showStoryListDetailsView: Bool = false

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
            let newStories = try await storiesRepository.fetchStories()
            stories += newStories
            loadingState = .success
        } catch {
            stories.removeAll()
            loadingState = .failure(error as? HTTPRequestService.RequestError)
        }
    }
    
    @MainActor
    func storyDidAppear(_ story: Story) {
        if story == stories.last {
            Task {
                let newStories = try await storiesRepository.fetchStories()
                let userIDs = Set(stories.map { $0.user.username })
                let filteredStories = newStories.filter { !userIDs.contains($0.user.username) }
                
                stories += filteredStories
            }
        }
    }
    
    func selectNextStory(_ ascending: Bool) {
        guard let selectedStory,
              let currentIndex = stories.firstIndex(where: { $0.id == selectedStory.id })else { return }

        let nextIndex = ascending ? currentIndex + 1 : currentIndex - 1

        guard (0..<stories.count).contains(nextIndex) else {
            return
        }

        self.selectedStory = stories[nextIndex]
    }
    
    func toggleSelectedStoryLiked() {
        selectedStory?.isLiked.toggle()
    }
}
