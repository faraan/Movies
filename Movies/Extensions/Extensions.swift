//
//  Extensions.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 15/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import UIKit

extension Optional where Wrapped : Collection{
    
    var nilIfEmpty: Wrapped? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}
