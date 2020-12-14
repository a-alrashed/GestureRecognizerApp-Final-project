//
//  Post.swift
//  AnimationApp
//
//  Created by Azzam R Alrashed on 10/12/2020.
//

import UIKit

class Post {
    let image:  UIImage
    let user: User
    let description: String
    
    init(image: UIImage, user: User , description: String) {
        self.image = image
        self.user = user
        self.description = description
    }
}

