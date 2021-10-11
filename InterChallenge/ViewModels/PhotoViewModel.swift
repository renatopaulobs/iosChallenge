//
//  PhotoViewModel.swift
//  InterChallenge
//
//  Created by Paulo  on 11/10/21.
//

import Foundation

public class PhotoViewModel {
    var photos = Box([Photo]())
    var photosCount = Box(0)
    var dowloadedData = Box(Data())
    var id = Box(0)
    
    func fetchPhotos(albumId: Int) {
        JsonPlaceholderService.getPhotosByAlbum(albumId: String(albumId)) {response in
            if (response != nil){
                let data = response!
                self.photos.value = data
                self.photosCount.value = data.count
            }
        }
    }
    
    func dowloadData(dataUrl: String) {
        JsonPlaceholderService.downloadResource(resourceUrl: dataUrl) { response in
            if (response != nil){
                let data = response!
                self.dowloadedData.value = data
            }
        }
    }
}
