//
//  startPageViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/30.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class startPageViewController: UIViewController {

    @IBOutlet weak var landPagePainting: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        landPagePainting.addShadowToView(alpha: 1.0, offsetWidth: 0, offsetHeight: 0, radius: 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
