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
        addShadow(view: landPagePainting)
    }
    
    // add shadow to image
    func addShadow(view: UIImageView){
        var layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
