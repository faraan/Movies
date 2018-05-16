//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var backgroundCellView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundCellView.layer.cornerRadius = 5.0
        backgroundCellView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- set all details on cell
    func setMovieData(movie: Movie){
        
        movieTitleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
        
        let posterUrl = URL(string: .kPosterUrl + movie.posterPath)
        
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: posterUrl, placeholder: #imageLiteral(resourceName: "poster_placeholder"))
    }

}
