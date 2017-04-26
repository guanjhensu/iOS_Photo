//
//  pagesViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/4/26.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class artistViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var seconfView: UIView!
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            firstView.isHidden = false
            seconfView.isHidden = true
        case 1:
            firstView.isHidden = true
            seconfView.isHidden = false
        default:
            break;
        }
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.isHidden = false
        seconfView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
