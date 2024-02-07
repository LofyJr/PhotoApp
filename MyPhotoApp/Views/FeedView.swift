//
//  ContentView.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 06/02/24.
//

import SwiftUI

func screenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

struct FeedView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @ObservedObject var commentsViewModel: CommentsViewModel
    @State var show: Bool = false
    @State var activeIndex: Int = -1
    var imageViewModel: ImageViewModel

    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
        self.imageViewModel = ImageViewModel()
        self.commentsViewModel = CommentsViewModel()
    }

    var feedListView: some View {
        GeometryReader { geo in
            ScrollView {
                ForEach(self.feedViewModel.posts.indices , id: \.self) { index in
                    GeometryReader { reader in
                        CardView(show: self.$show, post: self.$feedViewModel.posts[index], activeIndex: self.$activeIndex, commentsViewModel: self.commentsViewModel, index: index, imageViewModel: self.imageViewModel)
                            .padding(.top, self.show ? 20 : 0)
                            .offset(y: self.show ? -reader.frame(in: .global).minY + 40 : 0)
                    }
                    .frame(height: self.show ? (geo.frame(in: .global).height + geo.frame(in: .global).minY) - 40 : 400)
                    .offset(x: self.activeIndex != index && self.show ? screenSize().width + 40 : 0)
                }
            }
            .frame(height: self.show ? screenSize().height + geo.frame(in: .global).minY : geo.frame(in: .global).height)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration:  0))
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    var loadingView: some View {
        VStack {
            Spacer()
            ActivityIndicatorView()
                .onAppear {
                    self.feedViewModel.loadPosts()
                }
            Spacer()
        }
    }

    var showView: some View {
        switch self.feedViewModel.viewState {
            case .loading:
                return AnyView(loadingView)
            default:
                return AnyView(feedListView)
        }
    }

    var body: some View {
        ZStack{
            VStack {
                NavigationBarView()
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration:  0))
                    .offset(y: self.show ? -200 : 0)
                Spacer()
                VStack {
                    showView
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.feedViewModel.loadPosts()
        }
    }
}
