//
//  ViewController.swift
//  DeepArt
//
//  Created by 蘇冠禎 on 2017/3/10.
//  Copyright © 2017年 蘇冠禎. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UIImagePickerControllerDelegate {
    
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

    var imagePicker = UIImagePickerController()
    // no access to camera in simulator, so use photoLibrary instead
    // remember to set info -> Privacy - Photo Library Usage Description
    @IBAction func takePicture(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera() }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary() }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        imagePicker.delegate = self
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
//            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
//                self.imageView.image = image
//            }

        if var image = info[UIImagePickerControllerOriginalImage] as? UIImage {

            print("original: width \(image.size.width), height \(image.size.height)")
            var uploadSize = image.size.width
            if image.size.width > image.size.height {
                uploadSize = image.size.height
            }
            let cgImage = image.cgImage
            let toRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: uploadSize, height: uploadSize))
            let croppedCGImage: CGImage = cgImage!.cropping(to: toRect)!
            image = UIImage(cgImage: croppedCGImage, scale: UIScreen.main.scale, orientation: image.imageOrientation)
            
            self.imageView.image = image
        }

        takePictureButton.isHidden = false
        // after photo is chosen, go to next page
        self.performSegue(withIdentifier: "Choose", sender: self)
        dismiss(animated: true)
    }
}
extension ViewController: UINavigationControllerDelegate {
}
