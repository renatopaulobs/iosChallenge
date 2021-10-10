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
                }
        }
    }
}
