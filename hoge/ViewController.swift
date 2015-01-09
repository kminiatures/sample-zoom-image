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

        kama.frame.size = kama.image!.size
        board.contentSize = kama.frame.size
        board.delegate = self
        println(kama.frame)
        println(kama.image?.size.width)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return kama
    }

    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        println(scrollView.contentSize)
        let i:AnyObject = scrollView.subviews[0]
        if i is UIImageView{
            let size = (i as UIImageView).image!.size
            println(size)
            scrollView.contentSize = CGSizeMake(size.width * scale, size.height  * scale);
        }
    }

}

