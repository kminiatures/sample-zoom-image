//
//  ViewController.swift
//  hoge
//
//  Created by 小林　寛 on 2015/01/09.
//  Copyright (c) 2015年 yuco.name. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIScrollViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate

{
    @IBOutlet weak var board: UIScrollView!
    
    
    /// 画像ファイルの保存先パスを生成します（ドキュメントフォルダ直下固定）。
    var imagePath: String {
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return doc.stringByAppendingPathComponent("img1.jpg")
    }
    @IBAction func add(sender: AnyObject) {
        println("tap!")
        openImagePicker()
    }
    
    var img:UIImageView = UIImageView(image: UIImage(named: "1.6Mb.JPG"))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.frame.size = UIScreen.mainScreen().bounds.size
        
        //var img = UIImageView(image: UIImage(named: "1.6Mb.JPG"))
        img.contentMode = UIViewContentMode.ScaleAspectFill
        img.frame.size = board.frame.size
        var scale:CGFloat = 1.0
        //        scale = self.view.bounds.width / img.image!.size.width
        // 画像の画面に対するスケール
        //println(scale)
        

        //        img.frame = CGRectMake(0,0, i!.size.width * scale, i!.size.height * scale)
        
        println(img.frame)
        println(img.image)

        board.addSubview(img)
        println("before set delegate")
        board.delegate = self // board のメソッド実装先を自分にする
        println("after set delegate")
        
        UIApplication.sharedApplication().idleTimerDisabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let savedImage:UIImage? = UIImage(contentsOfFile: imagePath)
        if(savedImage == nil){
            openImagePicker()
        }else{
            img.image = savedImage
        }
    }
    
    
    // MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        println("viewForZoomingInScrollView")
        println(board.subviews[0])
       // return board.subviews[0] as UIImageView
        return img
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
    
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]
        ) {
            if info[UIImagePickerControllerOriginalImage] != nil {
                let image:UIImage = info[UIImagePickerControllerOriginalImage]  as UIImage
                
                let data = UIImageJPEGRepresentation(image, 0.9)
                data.writeToFile(imagePath, atomically: true)
                img.image = image
                
                println("save: \(imagePath)")
            }
            
            // 閉じる
            picker.dismissViewControllerAnimated(true, completion: nil);
    }

    // MARK: My Functions
    func openImagePicker() {
        let ipc:UIImagePickerController = UIImagePickerController();
        ipc.delegate = self
        ipc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(ipc, animated:true, completion:nil)
        
    }
}

