//
//  CoffeeViewModel.swift
//  CoffeeOrdering
//
//  Created by Nitin Bhatt on 11/11/20.
//

import Foundation

class CoffeeListViewModel:ObservableObject{
    var coffeeList:[CoffeeViewModel] = [CoffeeViewModel]()
}


struct CoffeeViewModel{
    var coffee: Coffee
    
    init(coffee:Coffee) {
        self.coffee = coffee
    }
    
    var name:String{
        return self.coffee.name
    }
    
    var image:String{
        return self.coffee.image
    }
    
    var price:Double{
        return self.coffee.price
    }
}
