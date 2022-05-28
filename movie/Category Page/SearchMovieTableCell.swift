//
//  SearchMovieTableCell.swift
//  movie
//
//  Created by abdulla hmaher on 10/31/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import Foundation
import UIKit

class searchMovieTableCell : UITableViewCell {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieCategory: UILabel!
    @IBOutlet var movieRate: UILabel!
    @IBOutlet var movieUrl: UILabel!
    
    func configureCell(searchmovie: searchTableCell){
        movieImage.image = searchmovie.image
        movieName.text = searchmovie.MovieName
        movieYear.text = searchmovie.MovieYear
        movieCategory.text = searchmovie.MovieCategory
        movieRate.text = searchmovie.MovieRate
        movieUrl.text = searchmovie.MovieURl
    }
}
