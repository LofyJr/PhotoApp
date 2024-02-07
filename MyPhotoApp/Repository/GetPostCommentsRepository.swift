//
//  GetPostCommentsRepository.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation
import Combine

struct GetPostCommentsRepository {

    func loadComments(post: Post) -> AnyPublisher<[Comment], Error> {
        var request = URLRequest(url: URL(string: "http://\(post.id)/comments")!)
        request.setValue("Bearer ...", forHTTPHeaderField: "Authoriation")
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.requestError
                }
                return data
            }
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
