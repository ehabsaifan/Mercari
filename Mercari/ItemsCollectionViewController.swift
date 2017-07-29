//
//  ItemsCollectionViewController.swift
//  Mercari
//
//  Created by Ehab Saifan on 7/28/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ItemCell"
private let defaultIdentifier = "DefaultCell"

class ItemsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var items = [Item](){
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let count = (self.items.count > 0 ? items.count: 1)
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultIdentifier, for: indexPath) as! DefaultCollectionViewCell
        
        if items.count != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            
        }
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.items.count == 0 {
            print("here....")
            return CGSize(width: (self.collectionView?.bounds.width)!, height: (self.collectionView?.bounds.height)!)
        }
        print("Not here....")
        let minCellWidth:CGFloat = 98.6
        let h = minCellWidth + 45
        return CGSize(width: minCellWidth, height: h)
    }
    
    
}
