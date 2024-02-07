//
//  Post.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation

struct Post: Identifiable {
    var id: UUID = UUID()
    var userImage: String
    var userName: String
    var location: String
    var timePostedSinceNow: String
    var postImage: String
    var commentCount: Int
    var likeCount: Int

    var showComment: Bool = false
}

extension Post: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userImage = "user_image"
        case userName = "user_name"
        case location = "location"
        case timePostedSinceNow = "time_posted_since_now"
        case postImage = "post_image"
        case commentCount = "comment_count"
        case likeCount = "like_count"
    }
}

let postData = [
    Post(userImage: "image1", userName: "Mile_f", location: "Brasil, Brusque", timePostedSinceNow: "2 minutes ago", postImage: "image1", commentCount: 12, likeCount: 54),
    Post(userImage: "image2", userName: "Carlos_J", location: "Brasil, Guabiruba", timePostedSinceNow: "4 minutes ago", postImage: "image2", commentCount: 43, likeCount: 65),
    Post(userImage: "image3", userName: "Dorlan", location: "Brasil, Tomaz Coelho", timePostedSinceNow: "3 minutes ago", postImage: "image3", commentCount: 123, likeCount: 324),
    Post(userImage: "image4", userName: "Katia_F", location: "Brasil, Centro I", timePostedSinceNow: "31 minutes ago", postImage: "image4", commentCount: 34, likeCount: 23),
    Post(userImage: "image5", userName: "Thais", location: "Brasil, Paquetá", timePostedSinceNow: " 15 minutes ago", postImage: "image5", commentCount: 2, likeCount: 742)
]
