//
//  ImageRepository.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation
import Combine

struct ImageRepository {

    func loadImage(url: String) -> AnyPublisher<Data, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: URL(string: url)!)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.requestError
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
