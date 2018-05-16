//
//  SearchResultsViewController.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 17/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var selectedString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       tableView.reloadData()
    }

}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return StaticHelper.shared.searchedTextArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = StaticHelper.shared.searchedTextArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedString = StaticHelper.shared.searchedTextArray[indexPath.row]
        
        performSegue(withIdentifier: "unwindToSearchVC", sender: self)
        dismiss(animated: true) {
            
        }
    }

}
