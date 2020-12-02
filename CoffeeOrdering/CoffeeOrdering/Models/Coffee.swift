//
//  Coffee.swift
//  CoffeeOrdering
//
//  Created by Nitin Bhatt on 11/7/20.
//

import Foundation

struct Coffee {
    let name:String
    let image: String
    let price: Double
}

extension Coffee{
    static func getCoffee() -> [Coffee]{
        return [Coffee(name: "Cappuccino", image: "cappuccino-coffee", price: 40),
                Coffee(name: "Expresso", image: "expresso-coffee", price: 50),
                Coffee(name: "Regular", image: "coffee", price: 30)]
    }
}
