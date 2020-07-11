//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var model: PostViewModel
    @State var showNewPostView = false
    var body: some View {
        // TODO: This should look exactly like the Birdie table view,
        // but with only one button.
        VStack(alignment: .center) {
            HStack {
//                Image("mascot_swift-badge")
//                    .resizable()
//                    .frame(width: 40, height: 40, alignment: .leading)
                Spacer()
                Text("Home")
//                    .padding(.trailing, 40.0)
                Spacer()
            }
            Spacer()
            HStack {
                Button(action: {
                    self.showNewPostView = true
                }) {
                    Text("Create New Post")
                }
                .padding(.leading, 10.0)
                .sheet(isPresented: $showNewPostView) {
                    NewPostView(postHandler: self.model)
                }
                Spacer()
            }
            
            List(model.posts) { post in
                PostView(post: post)
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView(model: PostViewModel())
  }
}
