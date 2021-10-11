//
//  ChallengeViewModel.swift
//  InterChallenge
//
//  Created by Paulo  on 09/10/21.
//

import Foundation

public class ChallengeViewModel {
    var users = Box([User]())
    var usersCount = Box(0)
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        JsonPlaceholderService.getUsers() {response in
            if (response != nil){
                let data = response!
                self.users.value = data
                self.usersCount.value = data.count
            }
        }
    }
}
