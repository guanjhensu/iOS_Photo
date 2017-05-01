//
//  PaintingsTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/29.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire

class PaintingsTableViewController: UITableViewController {

    // receive image from ChooseViewController.swift
    var photoToPaintingsTableViewController: UIImage!{
        didSet {
            photoToUpload?.image = photoToPaintingsTableViewController
        }
    }
    
    @IBOutlet weak var photoToUpload: UIImageView!
    
    // for version2 use
    var whichPaintingChosen: String = ""
    var imageNameGenerated: String = ""
    
    @IBAction func chooseEgonSchiele(_ sender: Any) {
        whichPaintingChosen = "EgonSchieleHouseWithDryingLaundry"
        let randomImageName: String = randomString(length: 5)
    
        upload(image: photoToUpload.image!.resized(withPercentage: 0.2)!, name: randomImageName)
        imageNameGenerated = randomImageName
    }
    
    @IBAction func chooseCheng(_ sender: Any) {
        whichPaintingChosen = "Cheng_OCT1_35"
        let randomImageName: String = randomString(length: 5)
        
        upload(image: photoToUpload.image!.resized(withPercentage: 0.4)!, name: randomImageName)
        imageNameGenerated = randomImageName
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendChosenPainging" {
            let controller = segue.destination as! transformedTableViewController
            controller.requestImageName = imageNameGenerated
            // to-do: send painter name to next page
        }
    }
    
   
    @IBOutlet weak var paintingView1: UIView!
    @IBOutlet weak var paintingView2: UIView!
    @IBOutlet weak var paintingView3: UIView!
    @IBOutlet weak var paintingView4: UIView!
    @IBOutlet weak var paintingView5: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoToUpload?.image = photoToPaintingsTableViewController
        photoToUpload?.isHidden = true
        paintingView1.addShadowToView()
        paintingView2.addShadowToView()
        paintingView3.addShadowToView()
        paintingView4.addShadowToView()
        paintingView5.addShadowToView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                    upload.responseData { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    func randomString(length:Int) -> String {
        var s: String = ""
        for _ in (1...length) {
            s.append(String(arc4random()))
        }
        return s
    }
    
}

extension UIView {
    func addShadowToView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
    }
}

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
