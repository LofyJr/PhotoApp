//
//  CommentsViewModel.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation
import Combine

enum CommentsViewState {
    case loading
    case ready
    case error
}

class CommentsViewModel: ObservableObject {
    @Published var comments: [Comment]
    var getCommentsRepository: GetPostCommentsRepository
    var viewState: CommentsViewState
    var cancellable: AnyCancellable?

    init() {
        self.comments = []
        self.getCommentsRepository = GetPostCommentsRepository()
        self.viewState = .loading
    }

    func loadComments(post: Post) {
        cancellable = self.getCommentsRepository
            .loadComments(post: post)
            .delay(for: 0.5, scheduler: DispatchQueue.global())
            .sink ( receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.viewState = .error
                            self.comments = []
                        }
                }
            }){ comments in
                DispatchQueue.main.async {
                    self.viewState = .ready
                    self.comments = comments
                }
            }

    }
}
