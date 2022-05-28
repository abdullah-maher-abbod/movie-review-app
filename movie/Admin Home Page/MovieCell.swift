//
//  MovieCell.swift
//  movie
//
//  Created by abdulla hmaher on 10/26/19.
//  Copyright © 2019 abdulla hmaher. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell  {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieCategory: UILabel!
    @IBOutlet var movieRate: UILabel!
    @IBOutlet var movieUrl: UILabel!
    
    

    
    func configureCell(movie: tableCell){
    movieImage.image = movie.image
    movieName.text = movie.MovieName
    movieYear.text = movie.MovieYear
    movieCategory.text = movie.MovieCategory
    movieRate.text = movie.MovieRate
    movieUrl.text = movie.MovieURl
}
    
}
