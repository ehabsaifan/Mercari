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
        self.refreshController.tintColor = UIColor.blue
        self.refreshController.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        self.collectionView?.addSubview(self.refreshController)
    }
    
    @objc private func fetchData(){
        FetchManager.getItems { [unowned self] (suceess, error) in
            self.refreshController.endRefreshing()
        }
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
        
        if self.items.count != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.item = self.items[indexPath.row]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultIdentifier, for: indexPath) as! DefaultCollectionViewCell
    
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.items.count == 0 {
            return CGSize(width: collectionView.bounds.width-20, height: collectionView.bounds.height-20)
        }

        let minWidth = (320 - 20)/3 - 8
        let cellSize = CGSize(width: minWidth, height: 130)
        return cellSize
    }
    
}
