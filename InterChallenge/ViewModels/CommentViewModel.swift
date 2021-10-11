//
//  CommentViewModel.swift
//  InterChallenge
//
//  Created by Paulo  on 11/10/21.
//

import Foundation

public class CommentViewModel {
    var comments = Box([Comment]())
    var commentsCount = Box(0)
    
    func fetchComments(postId: Int) {
        JsonPlaceholderService.getCommentsByPost(postId: String(postId)) {response in
            if (response != nil){
                let data = response!
                self.comments.value = data
                self.commentsCount.value = data.count
            }
        }
    }
}
