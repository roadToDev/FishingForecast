//
//  FishInfoTableViewCell.swift
//  FishingForecast
//
//  Created by Alex on 3/27/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class FishInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var infoDescrLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
