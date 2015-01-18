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
    
    @IBAction func add(sender: AnyObject) {
        println("tap!")
        openImagePicker()
    }
    
    /// 画像ファイルの保存先パスを生成します（ドキュメントフォルダ直下固定）
    var imagePath: String {
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return doc.stringByAppendingPathComponent("img1.jpg")
    }
    
    // デフォルト画像
    var img:UIImageView = UIImageView(image: UIImage(named: "1.6Mb.JPG"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.frame.size = UIScreen.mainScreen().bounds.size
        img.contentMode = UIViewContentMode.ScaleAspectFit
        

        img.frame.size = board.frame.size

        board.addSubview(img)
        board.delegate = self // board のメソッド実装先を自分にする
        
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
//            let scale:Float = savedImage!.size.width
//            var scale:CGFloat = board.frame.size.width / savedImage!.size.width
            
//            board.contentSize = CGSizeMake(savedImage!.size.width * scale, savedImage!.size.height  * scale);

        }
    }
    
    
    // MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
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
            let imageView = i as UIImageView
            let size = imageView.frame.size
            println("imageView:\(imageView.frame) " +
                    "scale:\(scale) to-w:\(size.width * scale) to-h:\(size.height  * scale)")

            scrollView.contentSize = imageView.frame.size
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

