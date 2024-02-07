//
//  CardView.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 06/02/24.
//

import SwiftUI

struct CardView: View {
    @Binding var show: Bool
    @Binding var post: Post
    @Binding var activeIndex: Int
    var index: Int
    var imageViewModel: ImageViewModel

    var body: some View {
        VStack{
            HStack{
                RoundedImageView(url: post.userImage, imageViewModel: imageViewModel)
                    .frame(width: 45, height: 36)
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading){
                    Text(post.userName)
                        .font(.footnote)
                        .fontWeight(.bold)
                    HStack{
                        Text(post.location)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(post.timePostedSinceNow)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            RoundedImageView(url: post.postImage, imageViewModel: imageViewModel)
                .frame(height: 300)
                .shadow(color: Color.defaultShadowColor(), radius: 15, x: 5, y: 10)
            
            HStack(spacing: 30){
                Button(action: {}){
                    HStack {
                        Image(systemName: "heart").font(Font.headline.weight(.semibold))
                        Text("\(post.likeCount)").font(.caption)
                    }
                }.foregroundColor(.black)
                
                Button(action: {}){
                    HStack{
                        Image(systemName: "bubble.right").font(Font.headline.weight(.semibold))
                        Text("\(post.commentCount)").font(.caption)
                    }
                }.foregroundColor(.black)
                Spacer()
            }
            .padding(.top)
            .padding(.bottom)
        }
        .padding(.leading)
        .padding(.trailing)
        .onTapGesture {
            self.show.toggle()
            self.post.showComment.toggle()
            if self.show {
                self.activeIndex = index
            } else {
                self.activeIndex = -1
            }
        }
    }
}
