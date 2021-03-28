//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
//
//    func setupCurrencyCell() {
//        amountLabel.font = UIFont(name: "SFProText-Bold", size: 25)
//
//    }
    
    func setCurrency(currency: Currency) {
        amountLabel.text = currency.amountLabel
        countryLabel.text = currency.country
        flagImageView.image = UIImage(named: currency.image)
    }
}
