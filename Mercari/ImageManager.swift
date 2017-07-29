//
//  ImageManager.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/28/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

class ImageManager: NSObject {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    static var currentManager = ImageManager()
    
    override init() {
        super.init()
        
        self.cache.countLimit = 100
    }
    
    
    /// Genrates a unique name for the images
    ///
    /// - Parameter name: a string reflects the a unique id represents the image
    /// - Returns: a unique strings represents the image name.
    class func generateImageName(name: String) -> String {
        return "pictures/\(name).jpeg"
    }
    
    
    /// This method retrieves the image in case it has been cashed before
    ///
    /// - Parameters:
    ///   - path: image URL string
    ///   - cashPath: Unique path where to save the cashed images
    ///   - completion: completion block contains image, error and the URL path used to get the image
    class func getImage(path: String, cashPath: String, completion :ImageResponse){
        
        if let image = ImageManager.currentManager.cache.object(forKey: cashPath as AnyObject), let completion = completion{
            completion(path, image as? UIImage, nil)
            return
        }
        
        if let _ = NSURL(string: path){
            NetworkManager.getImage(path: path, completion: { (path, image, error) -> Void in
                if let completion = completion{
                    if let image = image{
                        ImageManager.currentManager.cache.setObject(image, forKey: cashPath as AnyObject)
                    }
                    completion(path, image, nil)
                }
            })
        }
    }
}

