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
    
    var minCellWidth: CGFloat {
        //iPhone 5 width
        let minScreenSize = 320
        //Added in storyboard
        let sectionInset = 20
        let minSpacing = 8
        let minCellCountInARow = 3
        return CGFloat(((minScreenSize - sectionInset)/minCellCountInARow) - minSpacing)
    }
    
    var refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureRefreshController()
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "\(CustomNotification.ItemsHasBeenFetched)"), object: nil, queue: OperationQueue.main) { (not) -> Void in
           self.items = FetchManager.shared.items
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureRefreshController() {
        self.collectionView?.alwaysBounceVertical = true
        self.refreshController.tintColor = UIColor.blue
        self.refreshController.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        self.collectionView?.addSubview(self.refreshController)
    }
    
    @objc private func fetchData(){
        FetchManager.getItems { (suceess, error) in
            self.refreshController.endRefreshing()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // When there is no items we will display one default cell (Null cell)
        let count = (self.items.count > 0 ? items.count: 1)
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.items.count != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.item = self.items[indexPath.row]
            return cell
        }
        
        //Null cell to be displayed with a text when there is no
        //items.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultIdentifier, for: indexPath) as! DefaultCollectionViewCell
    
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //When there is no items we will display a full screen default cell
        if self.items.count == 0 {
            return CGSize(width: collectionView.bounds.width-20, height: collectionView.bounds.height-20)
        }

        let cellSize = CGSize(width: self.minCellWidth, height: 130)
        return cellSize
    }
    
}
