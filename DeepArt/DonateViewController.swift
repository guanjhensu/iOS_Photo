//
//  DonateViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/4/30.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {

    @IBAction func donateButton(_ sender: Any) {
        let alert = UIAlertController(title: "我支持台灣藝術創作者",
                                      message: "此濾鏡的版權屬於藝術家，若要上傳其他平台，請支付$30。其中$28歸藝術家所有，$2作為平台營運費用。",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "我願意", style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
