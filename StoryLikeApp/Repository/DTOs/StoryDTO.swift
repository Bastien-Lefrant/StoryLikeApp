//
//  StoryDTO.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import Foundation

struct StoryDTO: Decodable {
    let id: String
    let width: Int
    let height: Int
    let likes: Int
    let description: String?
    let user: UserDTO
    let urls: UrlsDTO

    private enum CodingKeys: String, CodingKey {
        case id, width, height, likes, description, user, urls
    }
}

// MARK: - Nested Types
extension StoryDTO {
    struct UrlsDTO: Decodable {
        let full: URL?
        let regular: URL?
        let small: URL?
    }
}
