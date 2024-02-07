//
//  CommentsView.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import SwiftUI

struct CommentsView: View {
    @Binding var post: Post
    @ObservedObject var commentsViewModel: CommentsViewModel
    var imageViewModel: ImageViewModel
    var showComments: some View {
        switch self.commentsViewModel.viewState {
            case .loading:
                return AnyView(activityView)
            case .error:
                return AnyView(errorView)
            case .ready:
                return AnyView(commentsView)
        }
    }

    var errorView: some View {
        Text("Error loading the comments")
    }

    var activityView: some View {
        ActivityIndicatorView()
            .onAppear {
                self.commentsViewModel.loadComments(post: self.post)
            }
    }

    var commentsView: some View {
        VStack {
            ScrollView {
                ForEach(self.commentsViewModel.comments) { comment in
                    CommentView(comment: comment, imageViewModel: self.imageViewModel)
                }
            }
        }
        .onDisappear {
            self.commentsViewModel.viewState = .loading
        }
    }

    var body: some View {
        showComments
    }
}

struct CommentView: View {
    var comment: Comment
    var imageViewModel: ImageViewModel
    var body: some View {
        VStack{
            HStack{
                RoundedImageView(url: comment.userImageUrl, imageViewModel: self.imageViewModel)
                    .frame(width: 30, height: 30)
                Text(self.comment.username).font(.footnote).fontWeight(.semibold)
                Spacer()
            }
            Text(self.comment.commentText)
                .foregroundColor(.secondary)
                .font(.body)
                .lineLimit(10)
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.bottom)
    }
}

