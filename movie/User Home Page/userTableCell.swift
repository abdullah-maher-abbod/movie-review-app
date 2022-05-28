//
//  userTableCell.swift
//  movie
//
//  Created by abdulla hmaher on 10/30/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import Foundation
import UIKit

class userTableCell {
    
    var image : UIImage
    var MovieName : String
    var MovieYear : String
    var MovieCategory : String
    var MovieRate : String
    var MovieURl : String
    
    init(Image : UIImage, movieName : String, movieYear : String, movieCategory : String, movieRate : String, movieUrl : String) {
        self.image = Image
        self.MovieName = movieName
        self.MovieYear = movieYear
        self.MovieCategory = movieCategory
        self.MovieRate = movieRate
        self.MovieURl = movieUrl
    }
}
