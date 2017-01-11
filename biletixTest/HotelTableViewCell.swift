//
//  HotelTableViewCell.swift
//  biletixTest
//
//  Created by Andrey Ildyakov on 10.01.17.
//  Copyright © 2017 Andrey Ildyakov. All rights reserved.
//

import UIKit
import AlamofireImage


class HotelTableViewCell: UITableViewCell {
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBAction func buyButtonAction(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("buyPress", object: nil)


    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configuration(hotel:HotelModel) {
        let url = NSURL(string: hotel.hotelImage)!
        hotelImage.af_setImageWithURL(url)
        hotelName.text = hotel.hotelName
        hotelPrice.text = hotel.hotelPrice
        buyButton.layer.borderWidth = 1
        buyButton.layer.cornerRadius = 3
        
    }

}
