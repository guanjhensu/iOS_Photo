//
//  transformedTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/29.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire


class transformedTableViewController: UITableViewController {

    @IBOutlet weak var transformedImageView: UIImageView?
    
    var uploadImage: UIImage!
    var modelName: String!
    
    @IBOutlet weak var ChengFoundationView: UIView!
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var museumView: UIView!
    @IBOutlet weak var ChengExhibitionView: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //museumView.addShadowToView()
        //movieView.addShadowToView()
        ChengExhibitionView.addShadowToView()
        ChengFoundationView.addShadowToView()
        
        print("\(modelName)")
        let randomImageName: String = modelName+"_____"+randomString(length: 5)
        upload(image: (uploadImage.resized(withPercentage: 0.4)!), name: randomImageName)
        
        
    }
    // upload photo to server
    func upload(image: UIImage, name: String) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
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
        Alamofire.request( requestUrl, method: .get)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    if image != nil {
                        self.transformedImageView?.image = image
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
    
    @IBAction func linkToChengExhibition(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/events/1605490479478390/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func linkToFoundation(_ sender: Any) {
        if let url = URL(string: "http://chenchengpo.dcam.wzu.edu.tw/~chenchengpo/index.php") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func linkToLeopoldMuseum(_ sender: Any) {
        if let url = URL(string: "http://www.leopoldmuseum.org/en/exhibitions/48/egon-schiele") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func LinkToSchieleMovie(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/watch?v=X3vHUX75S3o") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
