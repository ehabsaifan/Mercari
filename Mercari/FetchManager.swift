//
//  FetchManager.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/29/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

class FetchManager: NSObject {
    
    var places = [Place]()
    
    static var shared = FetchManager()
    
    override init(){
        super.init()
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { (not) -> Void in
            FetchManager.getPlaces(completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    class func getPlaces(completion: successResponse) {
        NetworkManager.getPlaces() { (json, error) in
            guard let error = error else{
                if let jsonList = json?["data"] as? [[String: AnyObject]]{
                    self.shared.places = jsonList.map({Place(info: $0)})
                }
                if let completion = completion {
                    completion(true, nil)
                }
                FetchManager.shared.postNotification(notification: CustomNotification.PlaceesHasBeenFetched)
                return
            }
            
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

