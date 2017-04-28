//
//  MainPageTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/4/25.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    
    @IBOutlet weak var exhibitionView: UIView!
    @IBAction func exhibitionLink(_ sender: Any) {
        if let url = URL(string: "http://www.inriver.com.tw/other/index.aspx?shop=inriver&kind=2&kind2=2") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        exhibitionView.addShadowToView()
        
        //ArtHubButton.layer.borderColor = UIColor(red: 0x99, green: 0x66, blue: 0x00, a: 0.26).cgColor
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
