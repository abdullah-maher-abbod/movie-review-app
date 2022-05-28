//
//  UserMovieCell.swift
//  movie
//
//  Created by abdulla hmaher on 10/30/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import Foundation
import UIKit
class UserMovieCell : UITableViewCell{
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieCategory: UILabel!
    @IBOutlet var movieRate: UILabel!
    @IBOutlet var movieUrl: UILabel!

    func configureCell(usermovie: userTableCell){
    movieImage.image = usermovie.image
    movieName.text = usermovie.MovieName
    movieYear.text = usermovie.MovieYear
    movieCategory.text = usermovie.MovieCategory
    movieRate.text = usermovie.MovieRate
    movieUrl.text = usermovie.MovieURl
}
}
