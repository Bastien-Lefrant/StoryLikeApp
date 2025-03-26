//
//  Story.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

struct Story: Identifiable {
    let id: String

    init(with storyDTO: StoryDTO) {
        self.id = storyDTO.id
    }
}
