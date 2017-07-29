//
//  Item.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/29/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import Foundation

struct Item {
    
    var id: String?          //"mall46",
    var name: String?        //"all46",
    var status: ItemStatus?  //"on_sale",
    var photo: String?       //"https://dummyimage.com/400x400/000/fff?text=all45",
    var n_comments: Int?     // 1,
    var n_likes: Int?        // 112,
    var price: Int?          // 5
    
    init(info: [String: AnyObject]) {
        self.id = info[ID] as? String
        self.name = info[NAME] as? String
        self.status = ItemStatus(rawValue: (info[STATUS] as? String ?? "").lowercased())
        self.photo = info[PHOTO] as? String ?? ""
        self.n_comments = info[N_COMMENTS] as? Int
        self.n_likes = info[N_LIKES] as? Int
        self.price = info[PRICE] as? Int 
    }
}

