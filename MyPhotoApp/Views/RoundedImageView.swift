//
//  RoundedImageView.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 06/02/24.
//

import SwiftUI
import Combine

struct RoundedImageView: View {
    var imageViewModel: ImageViewModel
    var imageName: String = "image1"
    var cornerRadius: CGFloat
    var url: String
    @State var data: Data?
    @State var cancellable: AnyCancellable?

    init(url: String, imageViewModel: ImageViewModel, cornerRadius: CGFloat = 5) {
        self.url = url
        self.imageViewModel = imageViewModel
        self.cornerRadius = cornerRadius
    }

    var loadingView: some View {
        ActivityIndicatorView()
            .onAppear {
                if let dataFromCache = ImageCache.getFromCache(imageUrl: self.url) {
                    self.data = dataFromCache
                    return
                }
                self.cancellable = self.imageViewModel.loadImage(url: self.url)
                    .sink(receiveValue: { data in
                        DispatchQueue.main.async {
                            self.data = data
                        }
                        ImageCache.setToCache(data: data, imageUrl: self.url)
                    })
            }
    }
    
    var imageView: some View {
        Image(uiImage: self.data!.count == 0 ? UIImage(named: imageName)! : UIImage(data: self.data!)!)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    var showView: some View {
        Group {
            if self.data == nil {
                loadingView
            } else {
                imageView
            }
        }
    }

    var body: some View {
        showView
    }
}
