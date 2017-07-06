//
//  ViewController.swift
//  SeeFood
//
//  Created by Dan on 7/3/17.
//  Copyright © 2017 dtran. All rights reserved.
//

import UIKit
import Alamofire
import Clarifai

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicked : UIImage?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showAlert(Title: String!, Message: String!) -> UIAlertController {
        
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            print ("User pressed ok function")
        }
        
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        return alertController
    }
    
    
    
    @IBAction func uploadTapped(_ sender: Any) {
        
        let alertController: UIAlertController = UIAlertController(title: "Upload", message: "Select Camera or Photo Library", preferredStyle: .actionSheet)
        
        let cameraAction : UIAlertAction = UIAlertAction(title: "Camera", style: .default, handler: {(cameraAction) in
            
            print("Camera selected")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == true {
                
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
            
            else{
                self.present(self.showAlert(Title: "Title", Message: "Camera is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
            }
        })
        
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
        (libraryAction) in
            
            print("Photo Library Selected")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) == true {
                
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
                
            else{
                self.present(self.showAlert(Title: "Title", Message: "Photo Library is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
                
                
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
        (cancelAction) in
            print ("Cancel Action was pressed")})
        
        
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        self.present(alertController, animated: true, completion: nil)
        
    
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked = image
        }
        
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "pizzaIdentifier", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! PizzaViewController
        viewController.pizza = imagePicked
    }

    
    
    
}
