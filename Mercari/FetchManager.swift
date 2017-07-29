//
//  FetchManager.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/29/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

class FetchManager: NSObject {
    
    var places = [Item]()
    
    static var shared = FetchManager()
    
    override init(){
        super.init()
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { (not) -> Void in
            FetchManager.getItems(completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    class func getItems(completion: successResponse) {
        NetworkManager.getItems() { (json, error) in
            
            guard let error = error else{
                
                guard let result = json?["result"] as? String, result.lowercased() == "ok" else {
                    if let completion = completion {
                        completion(true, nil)
                    }
                    return
                }// end guard result
                
                if let jsonList = json?["data"] as? [[String: AnyObject]]{
                    self.shared.places = jsonList.map({Item(info: $0)})
                }
                if let completion = completion {
                    completion(true, nil)
                }
                FetchManager.shared.postNotification(notification: CustomNotification.ItemsHasBeenFetched)
                return
            }// end guard error
            
            if let completion = completion {
                completion(false, error)
            }
        }
    }// end class func
    
    private func postNotification(notification: CustomNotification) {
        let notificationCenter = NotificationCenter.default
        let notificationObj = Notification(name: Notification.Name(rawValue: "\(notification)"))
        notificationCenter.post(notificationObj)
    }
}

