//
//  DependenciesContainer.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import Factory

extension Container {
    var storiesRepository: Factory<StoriesRepositoryProtocol> {
        Factory(self) { StoriesRepository() }
    }

    var httpRequestService: Factory<HTTPRequestServiceProtocol> {
        Factory(self) { HTTPRequestService() }
    }
}
