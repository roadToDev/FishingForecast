//
//  ViewController.swift
//  FishingForecast
//
//  Created by Alex on 10/2/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ForecaApiManager.parse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

