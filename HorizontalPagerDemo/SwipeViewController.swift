//
//  SwipeViewController.swift
//  HorizontalPagerDemo
//
//  Created by NakashimaHiroki on 2017/01/10.
//  Copyright © 2017年 Marsbarmania. All rights reserved.
//

import UIKit

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5 * self.frame.size.width)) / self.frame.width)
    }
}

class SwipeViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView :UIScrollView!
    @IBOutlet weak var pageCont: UIPageControl!
    
    var scrollHeight:CGFloat!
    var scrollWidth:CGFloat!
    
    var galleryItems: [GalleryItem] = []
    let pageNum:Int  = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initGalleryItems()
        setupImages()
        setupScrollImages()
        setupPageControl()
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
    
    func setupPageControl(){
        pageCont.currentPage = 0
        pageCont.numberOfPages = pageNum
    }
    
    func setupImages() {
        let screenSize: CGRect = UIScreen.main.bounds
        scrollWidth = screenSize.width
        scrollHeight = screenSize.height * 0.5
        for i in 0 ..< pageNum {
            let n:Int = i+1
            // UIImageView
            let image:UIImage = UIImage(named:"pic_\(n)")!
            let imageView = UIImageView(image:image)
            imageView.contentMode = .scaleAspectFit
            imageView.tag = n
            
            self.scrollView.addSubview(imageView)
        }
    }
    
    func setupScrollImages(){
        
        // Dummy
        let imageDummy:UIImage = UIImage(named:"1")!
        var imgView = UIImageView(image:imageDummy)
        var subviews:Array = scrollView.subviews
        
        // 描画開始位置
        var px:CGFloat = 0.0
        let py:CGFloat = 0.0

        for i in 0 ..< subviews.count {
            imgView = subviews[i] as! UIImageView
            if (imgView.isKind(of: UIImageView.self) && imgView.tag > 0){
                
                var viewFrame:CGRect = imgView.frame
                viewFrame.origin = CGPoint(x: px, y: py)
                imgView.frame = viewFrame
                px += (scrollWidth)
            }
        }
        // UIScrollViewのコンテンツサイズを画像のtotalサイズに合わせる
        let nWidth:CGFloat = scrollWidth * CGFloat(pageNum)
        scrollView.contentSize = CGSize(width: nWidth, height: scrollHeight)
        
    }
    
    // MARK: UIScrollViewDelegate
    /*func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }*/
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.currentPage
        pageCont.currentPage = currentPage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
