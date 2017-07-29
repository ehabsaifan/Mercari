//
//  Constants.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/28/17.
//  Copyright © 2017 Mercari. All rights reserved.
//



/*
    ****************************
        Place Constants
    ****************************
*/

let ID = "id" //"mall46",
let NAME = "name" //"all46",
let STATUS = "status" //"on_sale",
let PHOTO = "photo" //"https://dummyimage.com/400x400/000/fff?text=all45"
let N_COMMENTS = "num_comments" // 1,
let N_LIKES = "num_likes" // 112,
let PRICE = "price" // 5,


/*
 ****************************
    Enums
 ****************************
 */

enum CustomNotification {
    case ItemsHasBeenFetched
}

enum ItemStatus: String {
    case on_sale
    case sold_out
}
