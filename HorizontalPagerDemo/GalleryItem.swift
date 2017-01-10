//
//  GalleryItem.swift
//  CardSwiper
//
//  Created by NakashimaHiroki on 2016/12/28.
//  Copyright © 2016年 Marsbarmania. All rights reserved.
//

import Foundation

class GalleryItem {
    
    var itemImage: String
    
    init(dataDictionary:Dictionary<String,String>) {
        itemImage = dataDictionary["itemImage"]!
    }
    
    class func newGalleryItem(_ dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }
}
