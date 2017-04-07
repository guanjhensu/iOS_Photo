//
//  transformedTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/29.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class transformedTableViewController: UITableViewController {

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

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
