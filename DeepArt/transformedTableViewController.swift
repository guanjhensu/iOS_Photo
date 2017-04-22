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

    var request: Alamofire.Request?
    var requestHowManyTimes: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        load()

        //if let serverURL = URL(string: "http://localhost:8080/transformed/image.jpg") {
            //transformedImageView.loadImage(url: serverURL)
        
    }
    
    
    func load(){
        
        request = Alamofire.request("http://localhost:8080/transformed/image2.jpg", method: .get)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.result.value {
                    
                    let image = UIImage(data: data)
                    if image != nil {
                        self.transformedImageView.image = image
                        print("haha!!")
                        
                    } else {
                        print("roor...")
                        self.requestHowManyTimes += 1
                        self.requestAgain()
                        
                        
                        
                    }
                }
        }

    }
    
    func requestAgain(){
        if requestHowManyTimes < 5 {
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
