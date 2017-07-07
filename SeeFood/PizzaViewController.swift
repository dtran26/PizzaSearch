//
//  PizzaViewController.swift
//  SeeFood
//
//  Created by Dan on 7/6/17.
//  Copyright © 2017 dtran. All rights reserved.
//

import UIKit
import Clarifai
import EZLoadingActivity

class PizzaViewController: UIViewController {

    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var result: UILabel!
    
    var pizza : UIImage?
    var app : ClarifaiApp?
    var isPizza : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        app = ClarifaiApp(apiKey: key)
        pizzaImage.image = pizza
        EZLoadingActivity.show("Loading...", disableUI: true)
        recognizeImage(image: pizza!)
        print("123\(isPizza)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func recognizeImage(image: UIImage) {
        if let app = app {
            app.getModelByName("food-items-v1.0", completion: { (model, error) in
                let clarifaiIMG = ClarifaiImage(image: self.pizza)!
                
                model?.predict(on: [clarifaiIMG], completion: { (outputs, error) in
                    print("%@", error ?? "no error")
                    guard
                        let clarifaiOutput = outputs
                        else {
                            print("Predict failed")
                            return
                    }
                    
                    if let clarifaiOutput = clarifaiOutput.first {
                        var tags = [String]()
                        for concept in clarifaiOutput.concepts {
                            tags.append(concept.conceptName)
                        }
                        for index in 0...3{
                            if tags[index] == "pizza"{
                                self.isPizza = true
                                
                            }
                        }
                        print(self.isPizza)
                        if self.isPizza == true{
                            self.result.text = "THIS IS PIZZA"
                            EZLoadingActivity.hide(true, animated: true)
                        }
                        else{
                            self.result.text = "THIS IS NOT PIZZA"
                            EZLoadingActivity.hide(true, animated: true)
                        }
                    }
                })
                
            })
        }
    }
}
