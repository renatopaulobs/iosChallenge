//
//  Coordinator.swift
//  InterChallenge
//
//  Created by Paulo  on 16/10/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    func start()
}
