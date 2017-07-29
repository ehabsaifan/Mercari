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
        return NSError(domain: RootPath, code: code, userInfo: userInfo)
    }
}

extension UIImageView{
    func makeCircular(radius : CGFloat? = nil){
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        if let radius = radius{
            self.layer.cornerRadius = radius
        }
        else{
            self.layer.cornerRadius = self.frame.size.height/2
        }
        
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}

extension UIButton{
    func makeCircularEdges(radius : CGFloat? = 4){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        if let radius = radius{
            self.layer.cornerRadius = radius
        }
    }
    
    func makeCircular(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = self.frame.size.height/2
    }
}

extension UIColor {
    static func myColor() -> UIColor {
        return UIColor(colorLiteralRed: 255/255, green: 198/255, blue: 0/255, alpha: 1)
    }
}


