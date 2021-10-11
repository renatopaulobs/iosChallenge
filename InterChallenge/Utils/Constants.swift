//
//  Constants.swift
//  InterChallenge
//
//  Created by Paulo  on 09/10/21.
//

import Foundation

class Constants {
    struct Domain {
        static let main = "https://jsonplaceholder.typicode.com"
    }
    
    struct APIEndpoint {
        static let getUsers = "\(Domain.main)/users"
        static let getAlbumsByUser = "\(Domain.main)/albums?userId="
        static let getPhotosByAlbum = "\(Domain.main)/photos?albumId="
        static let getPostsByUser = "\(Domain.main)/posts?userId="
        static let getCommentsByPost = "\(Domain.main)/comments?postId="
    }
    
    struct AlertMessage {
        static let errorTitle = "Erro"
        static let errorMessage = "Algo errado aconteceu. Tente novamente mais tarde."
        static let errorAction = "Ok"
    }
}


