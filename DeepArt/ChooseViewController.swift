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
            whiteView.addShadowToView(alpha: 0.5, offsetWidth: 0, offsetHeight: 1, radius: 1)
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


