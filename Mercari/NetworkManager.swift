//
//  NetworkManager.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/28/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

typealias json = [String : AnyObject]
typealias jsonResponse = ((_ data : json?, _ error : NSError?)->Void)?
typealias successResponse = ((_ success : Bool, _ error : NSError?)->Void)?
typealias ImageResponse = ((_ path : String, _ image : UIImage?, _ error : NSError?)->Void)?

let RootPath = "https://fetchy-interview.herokuapp.com"
let APIRootPath = RootPath + "/api"

class NetworkManager: NSObject {
    
    static let currentManager = NetworkManager()
    
    let sessionManager = URLSession.shared
    
    override init() {
        super.init()
    }
    
    internal func parseJSON(from data: Data) -> json? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
            return json
        } catch {
            return nil
        }
    }
    
    internal func request(_ url: NSURL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = URLRequest(url: url as URL)
        let task = self.sessionManager.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
    internal func downloadRequest(_ url: NSURL,completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) {
        let request = URLRequest(url: url as URL)
        let task = self.sessionManager.downloadTask(with: request) { (url, response, error) in
            completionHandler(url, response, error)
        }
        task.resume()
    }
}

//MARK: login/signup
extension NetworkManager{
    
    class func getPlaces(completion : jsonResponse){
        let path = APIRootPath + "/placedata"
        self.get(path: path, completion: { (data, error) -> Void in
            self.completion(json: data, error: error, completion: completion)
        })
    }
}

extension NetworkManager{
    
    class func get(path: String, completion : jsonResponse){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = NSURL(string: path)
        
        NetworkManager.currentManager.request(url!) { (data, response, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            var error: NSError?
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode  {
                switch statusCode {
                case 200...300:
                    if let data = data, let json = NetworkManager.currentManager.parseJSON(from: data){
                        self.completion(json: json, error: nil, completion: completion)
                    }else{
                        let error = NSError.error(message: "Error parse data")
                        self.completion(json: nil, error: error, completion: completion)
                    }
                case let (code):
                    let error = NSError.error(message: "Please try again later", code: code)
                    self.completion(json: nil, error: error, completion: completion)
                }// end switch status code
            }
            
            if let _ = error {
                error = NSError.error(message: "Network is down! Please try again later")
                self.completion(json: nil, error: error, completion: completion)
            }
        }
    }
    
    class func getImage(path: String, completion: ImageResponse){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let link = NSURL(string: path) {
            NetworkManager.currentManager.downloadRequest(link) { (url, response, error) in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                var error: NSError?
                
                if let statusCode = (response as? HTTPURLResponse)?.statusCode  {
                    switch statusCode {
                    case 200...300:
                        if let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                            self.completion(path: path, image: image, error: nil, completion: completion)
                        }else {
                            let error = NSError.error(message: "Can't Parse Image", code: -1)
                            self.completion(path: path, image: nil, error: error, completion: completion)
                        }
                    case let (code):
                        let error = NSError.error(message: "Please try again later", code: code)
                        self.completion(path: path, image: nil, error: error, completion: completion)
                    }// end switch status code
                }
                
                if let _ = error {
                    error = NSError.error(message: "Network is down! Please try again later")
                    self.completion(path: path, image: nil, error: error, completion: completion)
                }
            }
        }else{
            let error = NSError.error(message: "Unkown Link")
            self.completion(path: path, image: nil, error: error, completion: completion)
        }
    }
}

extension NetworkManager{
    class func completion(json : json?, error : NSError?, completion : jsonResponse){
        OperationQueue.main.addOperation { () -> Void in
            if let completion = completion{
                completion(json,error)
            }
        }
    }
    
    class func completion(path : String, image: UIImage?, error : NSError?, completion : ImageResponse){
        OperationQueue.main.addOperation { () -> Void in
            if let completion = completion{
                completion(path, image, error)
            }
        }
    }
}


