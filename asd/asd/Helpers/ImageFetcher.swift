//
//  ImageFetcher.swift
//  asd
//
//  Created by Vasiliy Samuilik on 4/16/20.
//  Copyright © 2020 Vasiliy Samuilik. All rights reserved.
//

import UIKit
import SDWebImage

class ImageFetcher {
    
    class func fetch(_ urlString: String, to: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        to.sd_setImage(with: url, completed: nil)
    }

    class func cancelCurrentLoading(imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }

}
