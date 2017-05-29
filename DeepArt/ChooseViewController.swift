//
//  ChooseViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/10.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire

var filterID: Int = -1
let filterDic = [
    ["image": "嘉義街景_OCT1_06.jpg", "artist": "陳澄波", "workName": "嘉義街景", "model": "OCT1_06"],
    ["image": "Ni_Chiang_Huai_danshui_church.jpg", "artist": "倪蔣懷", "workName": "淡水教堂", "model": "NI_Keelung02"],
    ["image": "陳植棋_台灣風景.jpg", "artist": "陳植棋", "workName": "台灣風景", "model": "chenchihchi_Taiwan"],
    ["image": "清流_OCS1_03.jpg", "artist": "陳澄波", "workName": "清流", "model": "OCS1_03"],
    ["image": "玉山積雪_OW1_05.jpg", "artist": "陳澄波", "workName": "玉山積雪", "model": "OW1_05"],
    ["image": "陳澄波_OCT1_35.jpg", "artist": "陳澄波", "workName": "淡水夕照", "model": "OCT1_35"],
//    ["image": "黃榮燦_恐怖的檢查.jpg", "artist": "黃榮燦", "workName": "恐怖的檢查", "model": ""],
    ["image": "石川欽一郎_台中豐原道.jpg", "artist": "石川欽一郎", "workName": "台中豐原道", "model": "Ishikawa_Taichung"],
//    ["image": "倪蔣懷_田寮港畔看基隆郵局.jpg", "artist": "倪蔣懷", "workName": "田寮港畔看基隆郵局", "model": ""],
    ["image": "石川欽一郎_總督府.jpg", "artist": "石川欽一郎", "workName": "總督府", "model": "Ishikawa_taiwan"]]


class ChooseViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    var newImage: UIImage!
    
    var myScrollView: UIScrollView!
    var fullSize: CGSize!
    

    var filter:[UIImageView] = []
    var newFilter: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // receive newImage from ViewController.swift
        selectedImage.image = newImage
        
        // create scrollview for filter-selection
        myScrollView = UIScrollView()
        myScrollView = createFilterChooseBar(scrollview: myScrollView)
        self.view.addSubview(myScrollView)
        
        for i in 0...7 {
            // make frame with shadow
            let whiteView = UIView(frame: CGRect(origin: CGPoint(x: (24 + i * 84),y: 0), size: CGSize(width: 60, height: 110)))
            whiteView.backgroundColor=UIColor.white
            whiteView.addShadowToView()
            myScrollView.addSubview(whiteView)
            
            // make painting image
            newFilter = UIImageView(image: UIImage(named: filterDic[i]["image"]!)!.scaled(to: CGSize(width: 300, height: 400), scalingMode: .aspectFill))
            newFilter?.frame = CGRect(origin: CGPoint(x: (24 + i * 84),y: 0), size: CGSize(width: 60, height: 90))
            filter.append(newFilter!)
            myScrollView.addSubview(filter[i])
            
            // make label text
            let workName = UILabel(frame: CGRect(origin: CGPoint(x: (24 + i * 84),y :90), size: CGSize(width: 60, height: 20)))
            workName.textAlignment = .center
            workName.text = filterDic[i]["workName"]!
            workName.textColor = UIColor(red: 0x99, green: 0x66, blue: 0x00, a: 0.75)
            workName.backgroundColor = .white
            workName.font = workName.font.withSize(10)
            myScrollView.addSubview(workName)
            
            // make button
            let btn = UIButton(type: .custom) as UIButton
            btn.backgroundColor = nil
            btn.frame = CGRect(x: (24 + i * 84), y: 0, width: 60, height: 110)
            btn.tag = i
            btn.addTarget(self, action: #selector(showArtistName), for: .touchUpInside)
            self.myScrollView.addSubview(btn)

        }

    }
    
    func createFilterChooseBar(scrollview myScrollview: UIScrollView) -> UIScrollView{
        fullSize = UIScreen.main.bounds.size
        // visible frame size
        myScrollView.frame = CGRect(
            x: 0, y: 470, width: fullSize.width,
            height: 112)
        // actual content size
        myScrollView.contentSize = CGSize(
            width: fullSize.width * 3,
            height: fullSize.height * 0.8)
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.scrollsToTop = false
        myScrollView.isDirectionalLockEnabled = true
        myScrollView.isPagingEnabled = false
        myScrollView.bounces = false
        
        return myScrollView
    }
   
    func showArtistName(sender:UIButton!){
        filterID = sender.tag
        
        let artistName = UILabel(frame: CGRect(origin: CGPoint(x: (24 + filterID * 84),y :110), size: CGSize(width: 60, height: 110)))
        artistName.textAlignment = .center
        artistName.text = filterDic[filterID]["artist"]!
        artistName.textColor = .white
        artistName.backgroundColor = UIColor(red: 76, green: 76, blue: 76, a: 0.5)
        artistName.font = artistName.font.withSize(10)

        let top = CGAffineTransform(translationX: 0, y: -110)
        UIView.transition(with: self.myScrollView, duration: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.myScrollView.addSubview(artistName)
            artistName.transform = top
            
        }, completion: { (finished: Bool) -> () in
            print("complete~")
            // go to "transformedTableViewController.swift"
            let btn = UIButton(type: .custom) as UIButton
            btn.backgroundColor = nil
            btn.frame = CGRect(x: (24 + filterID * 84), y: 0, width: 60, height: 110)
            btn.addTarget(self, action: #selector(self.filterSelected), for: .touchUpInside)
            self.myScrollView.addSubview(btn)
        
        })
    }

    func filterSelected(sender: UIButton!){
        let styleTransferArtistSegueID = filterDic[filterID]["artist"]!
        self.performSegue(withIdentifier: styleTransferArtistSegueID, sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == filterDic[filterID]["artist"]! {
            let controller = segue.destination as! StyleTransferredTableViewController
            controller.uploadImage = newImage
        }
    }
}


// MARK: - Image Scaling.
// Usage:
//image.scaled(to: size)
//image.scaled(to: size, scalingMode: .aspectFill)
//image.scaled(to: size, scalingMode: .aspectFit)
extension UIImage {
    
    /// Represents a scaling mode
    enum ScalingMode {
        case aspectFill
        case aspectFit
        
        /// Calculates the aspect ratio between two sizes
        ///
        /// - parameters:
        ///     - size:      the first size used to calculate the ratio
        ///     - otherSize: the second size used to calculate the ratio
        ///
        /// - return: the aspect ratio between the two sizes
        func aspectRatio(between size: CGSize, and otherSize: CGSize) -> CGFloat {
            let aspectWidth  = size.width/otherSize.width
            let aspectHeight = size.height/otherSize.height
            
            switch self {
            case .aspectFill:
                return max(aspectWidth, aspectHeight)
            case .aspectFit:
                return min(aspectWidth, aspectHeight)
            }
        }
    }
    
    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    ///
    /// - parameter:
    ///     - newSize:     the size of the bounds the image must fit within.
    ///     - scalingMode: the desired scaling mode
    ///
    /// - returns: a new scaled image.
    func scaled(to newSize: CGSize, scalingMode: UIImage.ScalingMode = .aspectFill) -> UIImage {
        
        let aspectRatio = scalingMode.aspectRatio(between: newSize, and: size)
        
        /* Build the rectangle representing the area to be drawn */
        var scaledImageRect = CGRect.zero
        
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        /* Draw and retrieve the scaled image */
        UIGraphicsBeginImageContext(newSize)
        
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

extension UIView {
    func addShadowToView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
    }
}
