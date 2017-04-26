//
//  ArtHubTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/4/26.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class ArtHubTableViewController: UITableViewController {

    @IBOutlet weak var work1: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var work2: UIImageView!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var work3: UIImageView!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var work4: UIImageView!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var work5: UIImageView!
    @IBOutlet weak var title5: UILabel!
    @IBOutlet weak var work6: UIImageView!
    @IBOutlet weak var title6: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool)
    {
        work1.alpha = 0.0
        title1.alpha = 0.0
        work2.alpha = 0.0
        title2.alpha = 0.0
        work3.alpha = 0.0
        title3.alpha = 0.0
        work4.alpha = 0.0
        title4.alpha = 0.0
        work5.alpha = 0.0
        title5.alpha = 0.0
        work6.alpha = 0.0
        title6.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            self.work1.alpha = 1.0
            self.title1.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 1, animations: {
            self.work2.alpha = 1.0
            self.title2.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 1.5, animations: {
            self.work3.alpha = 1.0
            self.title3.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 2, animations: {
            self.work4.alpha = 1.0
            self.title4.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 2.5, animations: {
            self.work5.alpha = 1.0
            self.title5.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 3, animations: {
            self.work6.alpha = 1.0
            self.title6.alpha = 1.0
        }, completion: nil)
            
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
