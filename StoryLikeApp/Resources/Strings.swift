//
//  Strings.swift
//  CheerzTest
//
//  Created by Bastien Lefrant on 06/11/2024.
//

enum Strings {
    enum PhotosListView {
        static let home = "Home"
        static let noResultMessage = "No result for:"
    }

    enum PhotoDetailsView {
        static let createdAt = "Created at:"
        static let updatedAt = "Updated at:"
    }

    enum Errors {
        static let requestError = "Request error"
        static let serverError = "Server error"
        static let decodingError = "Decoding error"
        static let unknownError = "Unknown error"
    }

    enum Lotties {
        static let errorOccured = "ErrorOccured"
        static let mainLoader = "MainLoader"
        static let noResult = "NoResult"
        static let placeholderLoader = "PlaceholderLoader"
    }
}
