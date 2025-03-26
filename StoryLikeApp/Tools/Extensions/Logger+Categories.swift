//
//  Logger+Categories.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import OSLog

extension Logger {
    private static let bundleIdentifier: String = Bundle.main.bundleIdentifier!

    static let repository = Logger(subsystem: bundleIdentifier, category: "repository")
    static let networking = Logger(subsystem: bundleIdentifier, category: "networking")
}
