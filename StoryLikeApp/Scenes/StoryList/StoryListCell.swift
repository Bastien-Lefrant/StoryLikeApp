//
//  StoryListCell.swift
//  StoryLikeApp
//
//  Created by Bastien Lefrant on 26/03/2025.
//

import SwiftUI

struct StoryListCell: View {

    // MARK: Properties
    let story: Story

    // MARK: Views
    var body: some View {
        VStack {
            RoundedUserImage(url: story.user.profileImageURLs.large)
            Text(story.user.username)
                .font(.caption)
                .lineLimit(1)
                .foregroundStyle(Color(.textPrimary))
        }
        .padding(.bottom)
    }
}
