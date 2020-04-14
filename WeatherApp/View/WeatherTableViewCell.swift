//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by pallavi sharma on 02/04/2020.
//  Copyright © 2020 pallavi sharma. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var lblweatherDate : UILabel!
    @IBOutlet var lblWeatherDescription : UILabel!
    @IBOutlet var lblWeatherTemp : UILabel!

    @IBOutlet var imgWeatherIcon : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
