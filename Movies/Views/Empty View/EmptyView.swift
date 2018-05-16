//
//  EmptyView.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 17/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    //MARK:- Load view
    class func loadView() -> EmptyView{
        
        let emptyView = Bundle.main.loadNibNamed("EmptyView", owner: nil, options:  nil)?.first as! EmptyView
        var frame = UIScreen.main.bounds
        
        frame.size.height = (350.0 / 667.0) * UIScreen.main.bounds.size.height
        
        emptyView.frame = frame
        
        return emptyView
    }
    
    //MARK:- Add to super view 
    func show(view: UIView, title: String){
        
        titleLabel.text = title
        
        self.removeFromSuperview()
        view.addSubview(self)
        
        self.center = view.center
    }
}
