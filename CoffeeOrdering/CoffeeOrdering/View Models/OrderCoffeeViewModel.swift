//
//  OrderCoffeeViewModel.swift
//  CoffeeOrdering
//
//  Created by Nitin Bhatt on 11/7/20.
//

import Foundation

class OrderCoffeeListViewModel: ObservableObject{
    
    @Published var coffeeName = ""
    @Published var size = "Medium"
    @Published var orders = [OrderViewModel]()

    var totalPrice:String{
        return calculateTotalPrice()
    }
    
    init(){
        fetchAllOrders()
    }
    
    func fetchAllOrders() {
        self.orders = CoreDataManager.shared.getAllOrders().map(OrderViewModel.init)
    }
    
    func deleteOrder(order: OrderViewModel) {
        CoreDataManager.shared.deleteOrder(name: order.name)
        fetchAllOrders()
    }
    
    private func sizePrice() -> Double {
        let prices = ["Small":2.0, "Medium":3.0, "Large":4.0, "Extra-Large":6.0]
        return prices[self.size]!
    }
    
    func calculateTotalPrice()->String{
        let coffeePrice = coffeeList.first { $0.name == coffeeName }
        if let coffeePrice = coffeePrice {
            return String(format: "$%.2f",coffeePrice.price * sizePrice())
        } else {
            return String(format: "$%.2f",0)
        }
    }
    
    var coffeeList: [CoffeeViewModel] {
        return Coffee.getCoffee().map(CoffeeViewModel.init)
    }
    
    func saveOrder() {
        CoreDataManager.shared.saveOrder(name: self.coffeeName, price: self.totalPrice, size: self.size)
    }
}

class OrderViewModel {
    var name = ""
    var size = ""
    var price = ""
    
    init(order: Order) {
        self.name = order.name!
        self.size = order.size!
        self.price = order.price!
    }
}



