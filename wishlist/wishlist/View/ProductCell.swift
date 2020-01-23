//
//  ProductCell.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 23/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var wageLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureView(withName name: String, andWage wage: Int32, forPrice price: Int32, andResultHours hours: Int32){
        self.nameLbl.text = name
        self.wageLbl.text = "Wage : \(wage)"
        self.priceLbl.text = "Price : \(price)"
        self.hoursLbl.text = String(describing: hours)
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
