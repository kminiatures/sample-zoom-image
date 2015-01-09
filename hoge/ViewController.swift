//
//  ViewController.swift
//  hoge
//
//  Created by 小林　寛 on 2015/01/09.
//  Copyright (c) 2015年 yuco.name. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var kama: UIImageView!
    @IBOutlet weak var board: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kama.frame.size = kama.image!.size // ImageView に画像のサイズを設定。画像を動的に取得するときのために。
        board.contentSize = kama.frame.size // ScrollView に画像のサイズを設定
        board.delegate = self // board のメソッド実装先を自分にする
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return kama
    }

    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        // ズームにより scrollView のサイズが変更されてしまうので、
        // ズーム終了時に再設定する。
        let i:AnyObject = scrollView.subviews[0]
        if i is UIImageView{ // 画像ならば
            // UIView から UIImageView にダウンキャストする
            // UIView -> UIImageView ダウンキャスト
            // UIImageView -> UIView アップキャスト
            let size = (i as UIImageView).image!.size
            scrollView.contentSize = CGSizeMake(size.width * scale, size.height  * scale);
        }
    }

}

