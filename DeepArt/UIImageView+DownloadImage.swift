//
//  UIImageView+DownloadImage.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/4/20.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Foundation

var round: Int = 0
extension UIImageView {
    //func loadImage(url: URL) -> URLSessionDownloadTask {
    func loadImage(url: URL) {
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 70
            configuration.timeoutIntervalForResource = 70
            return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        }()
        
        
        //var totalRound: Int = 0
        myLoop: while round < 10 {
            let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("statusCode: \(statusCode)")
                    var status: Bool = true
                    
                    //myLoop: while round < 10 {
                    switch status {
                    case statusCode >= 200 && statusCode <= 299 :
                        round = 10
                        if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                if let strongSelf = self {
                                    strongSelf.image = image
                                }
                            }
                        }
                    default:
                        print("no image")
                        sleep(3)
                        round += 1
    
                    }
                }
                
            })
        downloadTask.resume()
        }
  
        return
        
    }
}
