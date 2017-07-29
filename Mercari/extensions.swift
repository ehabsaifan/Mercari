//
//  extensions.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/28/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

extension NSError{
    class func error(message : String, code: Int = 0) -> NSError {
        let userInfo = [
            NSLocalizedDescriptionKey : NSLocalizedString(message, comment: "")
        ]
        return NSError(domain: "Mercari App", code: code, userInfo: userInfo)
    }
}

extension UIView{
    func makeCircularEdges(radius : CGFloat? = 4, border: Bool = true){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = border ? 1: 0
        if let radius = radius{
            self.layer.cornerRadius = radius
        }
        self.clipsToBounds = true
    }
    
    func makeCircular(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.size.height/2
    }
}



