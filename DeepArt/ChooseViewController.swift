//
//  ChooseViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/10.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire

class ChooseViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var containerViewForPaintings: UIView!
    
    var newImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // receive newImage from ViewController.swift
        selectedImage.image = newImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseOnePainting" {
            let controller = segue.destination as! PaintingsTableViewController
            controller.photoToPaintingsTableViewController = newImage
        }
    }
}
