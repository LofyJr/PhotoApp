//
//  GetPostsRepository.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation
import Combine

struct GetPostsRepository {

    func execute() -> AnyPublisher<[Post], Error> {

        var request = URLRequest(url: URL(string: "http://")!)
        request.setValue("getHeaderToken", forHTTPHeaderField: "getHeader")
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
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
