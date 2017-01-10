//
//  DataViewCell.swift
//  CardSwiper
//
//  Created by NakashimaHiroki on 2016/12/27.
//  Copyright © 2016年 Marsbarmania. All rights reserved.
//

import UIKit

class DataViewCell: UICollectionViewCell {

    @IBOutlet var itemImageView: UIImageView!
    
    func setGalleryItem(_ item:GalleryItem) {
        itemImageView.image = UIImage(named: item.itemImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
