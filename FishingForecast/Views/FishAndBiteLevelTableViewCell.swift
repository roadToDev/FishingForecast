//
//  FishAndBiteLevelTableViewCell.swift
//  FishingForecast
//
//  Created by Alex on 1/10/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class FishAndBiteLevelTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fishImage: UIImageView!
    
    
    @IBOutlet weak var biteLevelImage: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
