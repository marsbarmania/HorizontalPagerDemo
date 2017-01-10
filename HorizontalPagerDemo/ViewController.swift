//
//  ViewController.swift
//  CardSwiper
//
//  Created by NakashimaHiroki on 2016/12/27.
//  Copyright © 2016年 Marsbarmania. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pgctl: UIPageControl!
    
    var galleryItems: [GalleryItem] = []
    var positionX = CGFloat(0)
    var thePage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initGalleryItems()
        
        setPageNumber(1)
        collectionView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func initGalleryItems() {
        
        var items = [GalleryItem]()
        let inputFile = Bundle.main.path(forResource: "items", ofType: "plist")
        
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        
        for inputItem in inputDataArray as! [Dictionary<String, String>] {
            let galleryItem = GalleryItem(dataDictionary: inputItem)
            items.append(galleryItem)
        }
        
        galleryItems = items
    }
    
    fileprivate func setPageNumber(_ n:Int){
        self.currentPageLabel.text = String(n)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataViewCell", for: indexPath) as! DataViewCell
        
        cell.setGalleryItem(galleryItems[indexPath.row])
        
        return cell
        
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width * 0.9

        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let picDimension = self.view.frame.size.width * 0.9
        let leftRightInset = (self.view.frame.size.width - picDimension) / 2
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //setTheViewPosition()
    
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setTheViewPosition()
    }
    
    func setTheViewPosition(){
        let picDimension = self.view.frame.size.width * 0.9
        let leftRightInset = self.view.frame.size.width - picDimension
        
        let x = collectionView.contentOffset.x - (leftRightInset * CGFloat(thePage))
        let w = collectionView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        
        //collectionView.contentOffset.x -= (leftRightInset * CGFloat(currentPage))
        self.positionX = collectionView.contentOffset.x
        self.thePage = currentPage
        
        
        self.setPageNumber(currentPage+1)
        
        print("Current Page: \(currentPage) offsetX1 = \(x) width = \(self.view.frame.size.width) offset= \(collectionView.contentOffset) gap= \(x-positionX)")
        dump(collectionView.contentOffset)
        //print("Current Page: \(currentPage) offsetX = \(x) w=\(w) Inset= \(leftRightInset)")
    }


}

