//
//  User.swift
//  AnimationApp
//
//  Created by Azzam R Alrashed on 10/12/2020.
//

import UIKit

class User {
    let name: String
    let email: String
    let image: UIImage
    let bio: String
    
    init(name: String, email: String, image: UIImage, bio: String) {
        self.name = name
        self.email = email
        self.image = image
        self.bio = bio
    }
}
