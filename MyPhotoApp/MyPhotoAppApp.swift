//
//  MyPhotoAppApp.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 06/02/24.
//

import SwiftUI

@main
struct MyPhotoAppApp: App {
    var body: some Scene {
        WindowGroup {
            FeedView(feedViewModel: FeedViewModel())
        }
    }
}
