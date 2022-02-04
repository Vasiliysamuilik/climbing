//
//  ImageCollectionViewCell.swift
//  asd
//
//  Created by Vasiliy Samuilik on 5/18/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(urlString: String) {
        ImageFetcher.fetch(urlString, to: newsImage)
    }

}
