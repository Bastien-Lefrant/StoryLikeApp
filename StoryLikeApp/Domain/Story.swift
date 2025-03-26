//
//  Story.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import Foundation

struct Story: Identifiable, Hashable {
    let id: String
    let user: User
    let imageURLs: ImageURLs
    var isLiked: Bool = false

    init(with storyDTO: StoryDTO) {
        self.id = storyDTO.id
        self.user = User(username: storyDTO.user.username,
                         profileImageURLs: ImageURLs(small: storyDTO.user.profileImage.small,
                                                     medium: storyDTO.user.profileImage.medium,
                                                     large: storyDTO.user.profileImage.large))
        self.imageURLs = ImageURLs(small: storyDTO.urls.small,
                                   medium: storyDTO.urls.regular,
                                   large: storyDTO.urls.full)
    }
}

// MARK: - Nested Types
extension Story {
    struct ImageURLs: Equatable, Hashable {
        let small: URL?
        let medium: URL?
        let large: URL?
    }

    struct User: Equatable, Hashable {
        let username: String
        let profileImageURLs: ImageURLs
    }
}
