//
//  ViewController.swift
//  hoge
//
//  Created by 小林　寛 on 2015/01/09.
//  Copyright (c) 2015年 yuco.name. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var board: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.frame.size = UIScreen.mainScreen().bounds.size
        
        var img = UIImageView(image: UIImage(named: "1.6Mb.JPG"))
        img.contentMode = UIViewContentMode.ScaleAspectFill
        img.frame.size = board.frame.size
        var scale:CGFloat = 1.0
        //        scale = self.view.bounds.width / img.image!.size.width
        // 画像の画面に対するスケール
        //println(scale)
        

        //        img.frame = CGRectMake(0,0, i!.size.width * scale, i!.size.height * scale)
        
        println(img.frame)
        println(img.image)

        board.delegate = self // board のメソッド実装先を自分にする
        board.addSubview(img)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return board.subviews[0] as UIImageView
    }

    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        // ズームにより scrollView のサイズが変更されてしまうので、
        // ズーム終了時に再設定する。
        let i:AnyObject = scrollView.subviews[0]
        if i is UIImageView{ // 画像ならば
            // UIView から UIImageView にダウンキャストする
            // UIView -> UIImageView ダウンキャスト
            // UIImageView -> UIView アップキャスト
//            let size = (i as UIImageView).image!.size
            let size = (i as UIImageView).frame.size
            // println(size)
//            println(scale)
            scrollView.contentSize = CGSizeMake(size.width * scale, size.height  * scale);
        }
    }

}

