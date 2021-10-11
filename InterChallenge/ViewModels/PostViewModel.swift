//
//  PostViewModel.swift
//  InterChallenge
//
//  Created by Paulo  on 11/10/21.
//

import Foundation

public class PostViewModel {
    var posts = Box([Post]())
    var postsCount = Box(0)
    
    func getPostsBy(userId: Int) {
        JsonPlaceholderService.getPostsByUser(userId: String(userId)) {response in
            if (response != nil){
                let data = response!
                self.posts.value = data
                self.postsCount.value = data.count
            }
        }
    }

}
