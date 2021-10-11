//
//  AlbumViewModel.swift
//  InterChallenge
//
//  Created by Paulo  on 11/10/21.
//

import Foundation

public class AlbumViewModel {
    var albums = Box([Album]())
    var albumsCount = Box(0)
    
    func fetchPhotos(userId: Int) {
        JsonPlaceholderService.getAlbumsByUser(userId: String(userId)) {response in
            if (response != nil){
                let data = response!
                self.albums.value = data
                self.albumsCount.value = data.count
            }
        }
    }
}
