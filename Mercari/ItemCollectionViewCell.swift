//
//  ItemCollectionViewCell.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/29/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    //To keep track of the current image displayed
    //to eleminate image flickiring
    var imageURL = ""
    
    var item: Item? {
        didSet {
            if let item = self.item {
                self.updateUI(item: item)
            }// end if let
        }// end didSet
    }
    
    private func updateUI(item: Item) {
        let name = item.name ?? "N/A"
        self.nameLabel?.text  = name
        self.priceLabel?.text = "  $\(item.price ?? 0)  "
        
        switch item.status {
        case .some(.sold_out):
            self.statusImageView?.image = UIImage(named: "sold")
            self.statusImageView?.makeCircularEdges(radius: 4, border: false)
        default:
            self.statusImageView?.image = nil
        }
        if let height = self.priceLabel?.frame.height {
            self.priceLabel.makeCircularEdges(radius: height/2, border: false)
        }
        self.fechImage()
    }
    
    //Remove previouse image if existed
    //Fetch Image from cash if existed
    //Check if the image belongs to the cell that are currently displayed
    private func fechImage(){
        guard let path = self.item?.photo, let id = self.item?.id else{
            return
        }
        self.imageURL = path
        let cashPath = ImageManager.generateImageName(name: "\(id)")
        self.activityIndicator.startAnimating()
        ImageManager.getImage(path: path, cashPath: cashPath) { (path, image, error) in
            self.activityIndicator.stopAnimating()
            guard let image = image else{
                return
            }
            if self.imageURL == path {
                self.photo?.makeCircularEdges(radius: 4, border: false)
                self.photo?.image = image
            }
        }
    }

}
