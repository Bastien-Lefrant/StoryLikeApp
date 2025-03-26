//
//  UserDTO.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 02/11/2024.
//

import Foundation

extension PhotoDTO {
    struct UserDTO: Decodable {
        let id: String
        let username: String
        let profileImage: ProfileImageDTO
    }
}

// MARK: - Nested Types
extension PhotoDTO.UserDTO {
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
