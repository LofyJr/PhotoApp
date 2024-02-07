//
//  Comment.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation

struct Comment: Identifiable {
    var id: Int
    var userId: Int
    var postId: Int
    var username: String
    var userImageUrl: String
    var commentText: String
}

extension Comment: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case postId = "post_id"
        case username = "username"
        case userImageUrl = "user_image_url"
        case commentText = "comment_text"
    }
}
