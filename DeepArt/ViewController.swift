//
//  ViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/10.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePictureButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard !UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        takePictureButton.setTitle("", for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageView.image = nil
    }
    
    // send image to ChooseViewController.swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose" {
            let controller = segue.destination as! ChooseViewController
            controller.newImage = imageView.image
        }
    }

    
    // no access to camera in simulator, so use photoLibrary instead
    // remember to set info -> Privacy - Photo Library Usage Description
    @IBAction func takePicture(_ sender: UIButton) {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismiss(animated: true)
            return
        }
        imageView.image = image
        takePictureButton.isHidden = false
        // after photo is chosen, go to next page
        self.performSegue(withIdentifier: "Choose", sender: self)

        dismiss(animated: true)
    }
}
extension ViewController: UINavigationControllerDelegate {
}
