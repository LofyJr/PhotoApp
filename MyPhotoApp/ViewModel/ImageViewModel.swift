//
//  ImageViewModel.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation
import Combine

struct ImageViewModel {
    var imageRepository: ImageRepository = ImageRepository()

    func loadImage(url: String) -> AnyPublisher<Data, Never> {
        return imageRepository
            .loadImage(url: url)
            .replaceError(with: Data())
            .eraseToAnyPublisher()
    }
}


