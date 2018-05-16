//
//  Constants.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation


extension String{
    
    //    Movie db api Key
    
    static let kAPIKey              = "2696829a81b1b5827d515ff121700838"
    
    
    //    Base Url
    static let kBaseUrl             = "http://api.themoviedb.org"
    
    //    API Version
    static let kAPIVersion          = "/3/"
    
    static let kPosterSize92        = "w92"
    static let kPosterSize185       = "w185"
    static let kPosterSize500       = "w500"
    
    //    API Urls
    static let kSearchUrl           = .kBaseUrl + .kAPIVersion + "search/movie?api_key=" + .kAPIKey
    static let kPosterUrl           = "http://image.tmdb.org/t/p/" + .kPosterSize92
    
    // API response keys
    
    static let kResult              = "results"
    static let kTotalPages          = "total_pages"
    static let kPage                = "page"
    
    static let kId                  = "id"
    static let kTitle               = "title"
    static let kPosterPath          = "poster_path"
    static let kOverview            = "overview"
    static let kReleaseDate         = "release_date"
    
    static let kError               = "errors"
    
    //    Loading Text
    
    static let kLoading             = "Loading..."
    
    //    UserDefault keys

    static let kStoredSearch        = "storedSearch"
    
}
