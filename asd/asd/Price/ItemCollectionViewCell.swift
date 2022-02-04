//
//  ItemCollectionViewCell.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/22/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        style()
    }
    
    func setup(urlString: String) {
        ImageFetcher.fetch(urlString, to: imageView)
    }
    
    private func style() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
    }
}
