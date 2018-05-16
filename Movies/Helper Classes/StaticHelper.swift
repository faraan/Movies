//
//  StaticHelper.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StaticHelper: NSObject {

    static let shared = StaticHelper()

    // Get list of 10 previously searched query text for suggestions 
    var searchedTextArray : [String]{
        
        if let storedSearchArray = UserDefaults.standard.object(forKey: .kStoredSearch) as? [String] {
            
            return storedSearchArray
            
        }else{
            return [String]()
        }
    }
    
    let emptyView = EmptyView.loadView()
    
    // MARK: - Activity indicator methods
    
    func showActivity(text: String){
        
        let sizeValue = (40.0/375.0) * UIScreen.main.bounds.size.width
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size:  CGSize(width: sizeValue, height: sizeValue), message: text, messageFont: UIFont.systemFont(ofSize: 16.0), type: .ballClipRotatePulse, color: .white, padding: 0.0, displayTimeThreshold: 0, minimumDisplayTime: 0))
        
    }
    
    func hideActivity(){
        
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    //MARK: - EmptyView Methods
    
    func showEmptyView(view: UIView, title: String){
        
        emptyView.show(view: view, title: title)
    }
    
    func removeEmptyView(){
        
        emptyView.removeFromSuperview()
    }

    //MARK: -Get Main Window
    
    func mainWindow() -> UIWindow {
        let app = UIApplication.shared.delegate as? AppDelegate
        return (app?.window!)!
    }
    
     //MARK: -Get SearchResultsViewController
    
    func getSearchResultsVC() -> SearchResultsViewController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)

        let searchResultsVC = storyBoard.instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        
        return searchResultsVC
    }
}
