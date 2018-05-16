//
//  SearchMovieViewController.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: StaticHelper.shared.getSearchResultsVC())

    var movieListArray = [Movie]()
    
    var searchedString = ""
    
    var endPageCout = 0
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Unwind segue Method
    
    @IBAction func unwindFromStoredSearchTableVC(segue: UIStoryboardSegue){
    
        let searchResultsVC = segue.source as! SearchResultsViewController
        
        searchedString = searchResultsVC.selectedString
        
        if !searchedString.isEmpty{
            
            movieListArray = [Movie]()
            currentPage = 1
            endPageCout = 0
            callSearchMovieAPI(query: searchedString, page: currentPage)
            
        }
    }
    
    // MARK:- Custom Methods
    
    // setup search controller
    func setupSearchController(){
        
        // Setup the Search Controller.i
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.placeholder = "Search Movies"
       
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchController.searchBar

    }
    
    // configure
    func configure(){
        
        self.title = "Movies"
        
        setupSearchController()
        
        tableView.estimatedRowHeight = 162.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        StaticHelper.shared.showEmptyView(view: view, title: "Enter movie name in search box")
    }
    
    //MARK:- API call - search movie API Method
    func callSearchMovieAPI(query: String, page: Int){
        
        StaticHelper.shared.showActivity(text: .kLoading)
        
        let queryTextEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)

        APIHelper.shared.getRequest(urlString: .kSearchUrl + "&query=\(queryTextEncoded ?? "")" + "&page=\(page)") { (isSuccess, result) in
            
            if isSuccess{
                
                if let json = result as? [String : Any]{
                    
                    self.handleSearchAPIResponse(json: json)
                }
                
            }else{
                
                if let error = result as? Error{
                    
                    self.showAlert(title: "Error", message: error.localizedDescription)

                }
            }
            StaticHelper.shared.hideActivity()
        }
    }
    
    // Handle API response
    func handleSearchAPIResponse(json: [String : Any]){
        
        if let error = json[.kError] as? [String]{
            
            self.showAlert(title: "Error", message: error.first!)

        }
        
        if let movieArray = json[.kResult] as? [[String: Any]]{
            
            if movieArray.count > 0 {
                
                StaticHelper.shared.removeEmptyView()

                self.setAllMovieData(movieArray: movieArray)
                
                self.storeSuccessfulSearch()
                self.searchController.isActive = false
                self.tableView.reloadData()
                
            }else{
                
                self.showAlert(title: "Error", message: "No movies found")
                
            }
        }
        
        if let endPage = json[.kTotalPages] as? Int{
            
            self.endPageCout = endPage
        }
        
    }
    
    // set movie data and store in modal class array
    func setAllMovieData(movieArray: [[String: Any]]){
        
        for movieDetail in movieArray {
            
            if let id = movieDetail[.kId] as? Int, let movieTitle = movieDetail[.kTitle] as? String, let posterPath = movieDetail[.kPosterPath] as? String, let overview = movieDetail[.kOverview] as? String, let releaseDate = movieDetail[.kReleaseDate] as? String{
                
                let movie = Movie.init(id: id, title: movieTitle, posterPath: posterPath, overview: overview, releaseDate: releaseDate)
                
                movieListArray.append(movie)
            }
        }
    }
    
    //MARK:- Store sucessfull query to show suggestions on search
    
    func storeSuccessfulSearch(){
        
        var searchedTextArray = StaticHelper.shared.searchedTextArray
        
        if !searchedTextArray.contains(searchedString){
            
            if searchedTextArray.count <= 10 {
                
                if searchedTextArray.count == 10 {
                    searchedTextArray.removeFirst()
                }
                
                searchedTextArray.append(searchedString)
                UserDefaults.standard.set(searchedTextArray, forKey: .kStoredSearch)
            }
        }
        
        print(searchedTextArray)
    }
    
    //MARK:- Show alert view 
    func showAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        
        movieCell.setMovieData(movie: movieListArray[indexPath.row])
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == movieListArray.count{
            
            if endPageCout > currentPage{
                
                currentPage = currentPage+1

                callSearchMovieAPI(query: searchedString, page: currentPage)
            }
        }
    }
    
}

extension SearchMovieViewController: UISearchBarDelegate, UISearchResultsUpdating,UISearchControllerDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchedString = searchBar.text!
        
        if !searchedString.isEmpty{
            
            movieListArray = [Movie]()
            currentPage = 1
            endPageCout = 0
            callSearchMovieAPI(query: searchedString, page: currentPage)

        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchController.searchResultsController?.view.isHidden = false
    }
    
    
}
