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

    @IBOutlet weak var transformedImageView: UIImageView!

    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var museumView: UIView!
    var request: Alamofire.Request?
    var requestHowManyTimes: Int = 0
    var requestImageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        museumView.addShadowToView()
        movieView.addShadowToView()
        load()
        
    }
    
    func load(){
        let requestUrl = "http://localhost:3000/imagesToApp/" + requestImageName + ".jpg"
        //let requestUrl = "http://localhost:3000/imagesToApp/3203448679411755359151543354439448110663752247945.jpg"
        request = Alamofire.request( requestUrl, method: .get)
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
                        print("image hasn't been generated yet")
                        self.requestHowManyTimes += 1
                        self.requestAgain()
                    }
                }
        }
    }
    
    func requestAgain(){
        if requestHowManyTimes < 10 {
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.load), userInfo: nil, repeats: false)
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
