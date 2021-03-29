//
//  ChangeSelectionCell.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/28/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit

class ChangeSelectionCell: UITableViewCell {
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    
    @IBAction func leftCountryButton(_ sender: UIButton) {
        print("tapped")
    }
    
    func setSelections(currency: CurrencyOption) {
        leftCountryLabel.text = currency.leftCountry
        middleCountryLabel.text = currency.middleCountry
        rightCountryLabel.text = currency.rightCountry
        
        leftCountryImage.image = UIImage(named: currency.leftCountry)
        middleCountryImage.image = UIImage(named: currency.middleCountry)
        rightCountryImage.image = UIImage(named: currency.rightCountry)
    }
    
}
