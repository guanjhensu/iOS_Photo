//
//  PaintingsTableViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/29.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire

class PaintingsTableViewController: UITableViewController {

    // receive image from ChooseViewController.swift
    var photoToPaintingsTableViewController: UIImage!{
        didSet {
            photoToUpload?.image = photoToPaintingsTableViewController
        }
    }
    
    @IBOutlet weak var photoToUpload: UIImageView!
    
    // for version2 use
    var whichPaintingChosen: String = ""
    var imageNameGenerated: String = ""

    
    
    @IBAction func chooseEgonSchiele(_ sender: Any) {
        whichPaintingChosen = "EgonSchieleHouseWithDryingLaundry"
    }
    
    @IBAction func chooseCheng(_ sender: Any) {
        whichPaintingChosen = "OCT1_06"
    }
    
    // send taken photo to transformedTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendChosenPainging" {
            let controller = segue.destination as! transformedTableViewController
            controller.uploadImage = photoToUpload?.image!
            controller.modelName = self.whichPaintingChosen
        }
    }
    
   
    @IBOutlet weak var paintingView1: UIView!
    @IBOutlet weak var paintingView2: UIView!
    @IBOutlet weak var paintingView3: UIView!
    @IBOutlet weak var paintingView4: UIView!
    @IBOutlet weak var paintingView5: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoToUpload?.image = photoToPaintingsTableViewController
        photoToUpload?.isHidden = true
        paintingView1.addShadowToView()
        paintingView2.addShadowToView()
        paintingView3.addShadowToView()
        paintingView4.addShadowToView()
        paintingView5.addShadowToView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


