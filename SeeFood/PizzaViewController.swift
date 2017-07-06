//
//  PizzaViewController.swift
//  SeeFood
//
//  Created by Dan on 7/6/17.
//  Copyright © 2017 dtran. All rights reserved.
//

import UIKit
import Clarifai

class PizzaViewController: UIViewController {

    @IBOutlet weak var pizzaImage: UIImageView!
    
    var pizza : UIImage?
    var app : ClarifaiApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        app = ClarifaiApp(apiKey: key)
        recognizeImage(image: pizza!)
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
                        print(tags)
                    }
                })
                
            })
        }
    }
}
