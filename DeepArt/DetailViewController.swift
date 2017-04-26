//
//  DetailViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/4/26.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBAction func closeDetail(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
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

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController)
        -> UIPresentationController? {
            return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
