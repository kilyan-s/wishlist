//
//  Calculator.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 22/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import Foundation

class Calculator {
    class func getHours(forWage wage: String, andPrice price: String) -> String {
        guard let wage = Double(wage) else { return "" }
        guard let price = Double(price) else { return "" }
        let result = Int(ceil(price / wage))
        
        return String(result)
    }
}
