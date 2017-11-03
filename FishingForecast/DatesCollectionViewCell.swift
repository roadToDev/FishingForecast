//
//  DatesCollectionViewCell.swift
//  FishingForecast
//
//  Created by Alex on 11/1/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class DatesCollectionViewCell: UICollectionViewCell {
    
   @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var lineImage: UIImageView!
    
    @IBAction func dayChange(_ sender: UIButton) {
        print ("Push!")
    }        
}
