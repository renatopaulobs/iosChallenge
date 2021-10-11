//
//  JsonPlaceholderService.swift
//  InterChallenge
//
//  Created by Paulo  on 09/10/21.
//

import Foundation
import Alamofire

class JsonPlaceholderService {
    
    static func getUsers(completition: @escaping ([User]?) -> Void) {
        AF.request(Constants.APIEndpoint.getUsers)
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completition(nil)
                    return
                }
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([User].self, from: data)
                            completition(models)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completition(nil)
                }
        }
    }
    
    static func getPhotosByAlbum(albumId: String, completition: @escaping ([Photo]?) -> Void) {
        AF.request(Constants.APIEndpoint.getPhotosByAlbum+albumId)
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completition(nil)
                    return
                }
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Photo].self, from: data)
                            completition(models)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completition(nil)
                }
        }
    }
    
    static func getAlbumsByUser(userId: String, completition: @escaping ([Album]?) -> Void) {
        AF.request(Constants.APIEndpoint.getAlbumsByUser+userId)
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completition(nil)
                    return
                }
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Album].self, from: data)
                            completition(models)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completition(nil)
                }
        }
    }
    
    static func getCommentsByPost(postId: String, completition: @escaping ([Comment]?) -> Void) {
        AF.request(Constants.APIEndpoint.getCommentsByPost+postId)
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completition(nil)
                    return
                }
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Comment].self, from: data)
                            completition(models)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completition(nil)
                }
        }
    }
    
    static func getPostsByUser(userId: String, completition: @escaping ([Post]?) -> Void) {
        AF.request(Constants.APIEndpoint.getPostsByUser+userId)
            .validate()
            .responseJSON { response in
                guard response.error == nil else {
                    completition(nil)
                    return
                }
                do {
                    if let data = response.data {
                        let models = try JSONDecoder().decode([Post].self, from: data)
                            completition(models)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completition(nil)
                }
        }
    }
    
    static func downloadResource(resourceUrl: String, completition: @escaping(Data?) -> Void){
        AF.download(resourceUrl).responseData { response in
            switch response.result {
            case .success(let data):
                completition(data)
            default:
                completition(nil)
                break
            }
        }
    }
    
}
