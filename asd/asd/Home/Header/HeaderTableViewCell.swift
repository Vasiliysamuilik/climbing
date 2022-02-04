//
//  HeaderTableViewCell.swift
//  asd
//
//  Created by Vasiliy Samuilik on 5/24/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCollectionView: PageCollectionView!
    
    private var urls: [String] = []
    private var reuseId: String = "ImageCollectionViewCell"
    
    // Collection view constants
    private let itemWidth = UIScreen.main.bounds.width * 0.9
    private let sideInset: CGFloat = 10.0
    private let bottomInset: CGFloat = 5.0
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        imageCollectionView.reloadData()
    }
    
    func set(imageUrls: [String]) {
        self.urls = imageUrls
        imageCollectionView?.reloadData()
    }
    
    private func setup() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        imageCollectionView.pageWidth = itemWidth + sideInset

        imageCollectionView.register(UINib(nibName: reuseId, bundle: nil), forCellWithReuseIdentifier: reuseId)
    }
    
}

//MARK: - UICollectionViewDataSource

extension HeaderTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! ImageCollectionViewCell
        cell.setup(urlString: urls[indexPath.item])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension HeaderTableViewCell: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        imageCollectionView.scrollViewWillBeginDragging(scrollView)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        imageCollectionView.scrollViewWillEndDragging(scrollView,
                                                 withVelocity: velocity,
                                                 targetContentOffset: targetContentOffset)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HeaderTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.bounds.height - bottomInset
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: sideInset * 2, bottom: bottomInset, right: sideInset * 2)
    }
    
}
