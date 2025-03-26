//
//  PhotoDTO.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//


//
//  PhotoDTO.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 02/11/2024.
//

import Foundation

struct PhotoDTO: Decodable {
    let id: String
    let slug: String
    let createdAt: String
    let updatedAt: String
    let width: Int
    let height: Int
    let likes: Int
    let description: String?
    let altDescription: String?
    let user: UserDTO
    let urls: UrlsDTO

    private enum CodingKeys: String, CodingKey {
        case id, slug, width, height, likes, description, user, urls
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case altDescription = "alt_description"
    }
}

// MARK: - Nested Types
extension PhotoDTO {
    struct UrlsDTO: Decodable {
        let full: URL?
        let regular: URL?
        let small: URL?
    }
}
