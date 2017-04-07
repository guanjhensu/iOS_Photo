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
    
    @IBAction func chooseEgonSchiele(_ sender: Any) {
        whichPaintingChosen = "EgonSchieleHouseWithDryingLaundry"
        upload(image: photoToUpload.image!)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendChosenPainging" {
            let controller = segue.destination as! transformedTableViewController
            // to-do: send data to next page
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoToUpload?.image = photoToPaintingsTableViewController
        photoToUpload?.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // upload photo to server
    func upload(image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData,
                                         withName: "upload",
                                         fileName: "image.jpg",
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
}