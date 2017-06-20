//
//  StyleTransferredTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/5/28.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire

class StyleTransferredTableViewController: UITableViewController {

    var uploadImage: UIImage!
    var transformedImageView = UIImageView(image: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformedImageView.frame = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 375, height: 375))
        view.addSubview(self.transformedImageView)
        
        let randomImageName: String = filterDic[filterID]["model"]! + "_____" + randomString(length: 5)
        upload(image: (uploadImage.resized(withPercentage: 0.4)!), name: randomImageName)

    }

    // upload photo to server
    func upload(image: UIImage, name: String) {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData,
                                         withName: "upload",
                                         fileName: name,
                                         mimeType: "image/jpeg")
                
        },
            to: "http://127.0.0.1:3000",
//            to: "http://10.43.232.9:3000",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON  { response in
                        debugPrint(response)
                        // style transfer success!
                        self.load(requestImageName: name)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    // load photo to client
    func load(requestImageName: String){
        let requestUrl = "http://localhost:3000/imagesToApp/" + requestImageName + ".jpg"
//        let requestUrl = "http://10.43.232.9:3000/imagesToApp/" + requestImageName + ".jpg"
        Alamofire.request( requestUrl, method: .get)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    if image != nil {
                        self.transformedImageView.image = image
                        
                        print("image load success")
                    } else {
                        print("fail to find transferred image")
                    }
                }
        }
    }
    
    func randomString(length:Int) -> String {
        var s: String = ""
        for _ in (1...length) {
            s.append(String(arc4random()))
        }
        return s
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// resize image
extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

