//
//  Movie.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class Movie: NSObject {

    //MARK: Properties
    var id : Int
    var title : String
    var posterPath : String
    var overview : String
    var releaseDate : String
    
    
    //MARK: Init

    init(id: Int, title: String, posterPath: String, overview: String, releaseDate : String) {
        
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
}
