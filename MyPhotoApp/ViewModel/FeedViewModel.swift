//
//  FeedViewModel.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 06/02/24.
//

import Foundation
import Combine
import SwiftUI

enum FeedViewState {
    case loading
    case ready
    case error
}

class FeedViewModel: ObservableObject {
    @Published var posts: [Post]
    @Published var errorMessage: String

    var getPostsRepository: GetPostsRepository = GetPostsRepository()
    var viewState: FeedViewState
    var cancellable: AnyCancellable?

    init() {
        self.posts = []
        self.errorMessage = ""
        self.viewState = .loading
    }

    func loadPosts() {
        let subject = PassthroughSubject<[Post], Never>()
        cancellable = subject
            .sink(receiveValue: { posts in
                self.posts = posts
            })

        subject.send(postData)
    }

    func loadPost() {
        cancellable = getPostsRepository
            .execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(_):
                        self.viewState = .error
                        break
                    case .finished:
                        break
                }
            }, receiveValue: { posts in
                DispatchQueue.main.async {
                    self.viewState = .ready
                    self.posts = posts
                }
            })
    }
}
