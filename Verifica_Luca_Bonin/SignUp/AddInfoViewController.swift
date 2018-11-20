//
//  AddInfoViewController.swift
//  Verifica_Luca_Bonin
//
//  Created by Leo Luca Bonin on 20/11/2018.
//  Copyright © 2018 developer.llb. All rights reserved.
//

import UIKit

class AddInfoViewController: UIViewController {
    
    private var pickerController:UIImagePickerController?
    
    @IBOutlet weak var profileImage: UIButton! {
        didSet{
            profileImage.circleButton()
        }
    }
    
    @IBOutlet var textFields: [UITextField]!
    
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for textField in textFields {
            switch textField.tag {
            case 0:
                textField.text = user!.email
                textField.isUserInteractionEnabled = false

            case 1: textField.text = user!.name
            case 2 : textField.text = user!.surname 
            default: break;
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        for textField in textFields {
            switch textField.tag {
            case 1: user!.name = textField.text
            case 2 : user!.surname = textField.text
            default: break;
            }
        }
        
        NetworkManager.addUser(user: user!, completion: {
            success in
            if success {
                self.performSegue(withIdentifier: R.segue.addInfoViewController.toMainSegue, sender: self)
            }
        })
    }
    
    @IBAction func imageButtonAction(_ sender: Any) {
        
        self.pickerController = UIImagePickerController()
        self.pickerController!.delegate = self
        self.pickerController?.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "Foto profilo", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        #if !targetEnvironment(simulator)
        let photo = UIAlertAction(title: "Scatta foto", style: .default) { action in
            self.pickerController!.sourceType = .camera
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(photo)
        #endif
        
        let camera = UIAlertAction(title: "Carica foto", style: .default) { alert in
            self.pickerController!.sourceType = .photoLibrary
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(camera)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension AddInfoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img = checkImageSizeAndResize(image: image)
        user?.image = img.pngData()
        profileImage.setBackgroundImage(img, for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkImageSizeAndResize(image : UIImage) -> UIImage {
        
        let imageSize: Int = image.pngData()!.count
        let imageDimension = Double(imageSize) / 1024.0 / 1024.0
        print("size of image in MB: ", imageDimension)
        
        if imageDimension > 15 {
            
            let img = image.resized(withPercentage: 0.5) ?? UIImage()
            
            return checkImageSizeAndResize(image: img)
            
        }
        
        return image
        
        
    }
}
