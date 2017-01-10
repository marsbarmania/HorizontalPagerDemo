//
//  SwipeViewController.swift
//  HorizontalPagerDemo
//
//  Created by NakashimaHiroki on 2017/01/10.
//  Copyright © 2017年 Marsbarmania. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    @IBOutlet weak var scrollView :UIScrollView!
    
    // Screenの高さ
    var screenHeight:CGFloat!
    // Screenの幅
    var screenWidth:CGFloat!
    
    // Totalのページ数
    let pageNum:Int  = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenSize: CGRect = UIScreen.main.bounds
        
        screenWidth = screenSize.width
        
        let imageTop:UIImage = UIImage(named:"1")!
        
        let imageWidth = imageTop.size.width
        let imageHeight = imageTop.size.height
        screenHeight = screenWidth * imageHeight/imageWidth
        
        
        for i in 0 ..< pageNum {
            let n:Int = i+1
            
            // UIImageViewのインスタンス
            let image:UIImage = UIImage(named:"\(n)")!
            let imageView = UIImageView(image:image)
            
            var rect:CGRect = imageView.frame
            rect.size.height = screenHeight
            rect.size.width = screenWidth
            imageView.frame = rect
            imageView.tag = n
            
            // UIScrollViewのインスタンスに画像を貼付ける
            self.scrollView.addSubview(imageView)
            
        }
        
        setupScrollImages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScrollImages(){
        
        // ダミー画像
        let imageDummy:UIImage = UIImage(named:"1")!
        var imgView = UIImageView(image:imageDummy)
        var subviews:Array = scrollView.subviews
        
        // 描画開始の x,y 位置
        var px:CGFloat = 0.0
        let py:CGFloat = 100.0
        
        for i in 0 ..< subviews.count {
            imgView = subviews[i] as! UIImageView
            if (imgView.isKind(of: UIImageView.self) && imgView.tag > 0){
                
                var viewFrame:CGRect = imgView.frame
                viewFrame.origin = CGPoint(x: px, y: py)
                imgView.frame = viewFrame
                
                px += (screenWidth)
                
            }
        }
        // UIScrollViewのコンテンツサイズを画像のtotalサイズに合わせる
        let nWidth:CGFloat = screenWidth * CGFloat(pageNum)
        scrollView.contentSize = CGSize(width: nWidth, height: screenHeight)
        
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
