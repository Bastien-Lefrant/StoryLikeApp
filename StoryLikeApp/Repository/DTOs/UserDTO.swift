//
//  UserDTO.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import Foundation

extension StoryDTO {
    struct UserDTO: Decodable {
        let id: String
        let username: String
        let profileImage: ProfileImageDTO
    }
}

// MARK: - Nested Types
extension StoryDTO.UserDTO {
    struct ProfileImageDTO: Codable {
        let small: URL?
        let medium: URL?
        let large: URL?
    }

    private enum CodingKeys: String, CodingKey {
        case id, username
        case profileImage = "profile_image"
    }
}
