//
//  ContentView.swift
//  CoffeeOrdering
//
//  Created by Nitin Bhatt on 11/7/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
    @State private var isPresented = false
    @ObservedObject private var orderCoffeeViewModel = OrderCoffeeListViewModel()

    init() {
        UINavigationBar.appearance().backgroundColor = .blue
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
                   .font : UIFont(name:"Helvetica Neue", size: 40)!]
        self.orderCoffeeViewModel = OrderCoffeeListViewModel()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(self.orderCoffeeViewModel.orders, id: \.name) { order in
                       ContentViewCell(order: order)
                    }.onDelete(perform: self.deleteItem)
                }
            }
                .navigationBarTitle("Welcome")
                .navigationBarItems(trailing:
                  Button("Order Coffee") {
                        showCoffeeOrderView()
                    }.foregroundColor(.white)
                )
            
            .fullScreenCover(isPresented: $isPresented, onDismiss: {
                self.orderCoffeeViewModel.fetchAllOrders()
            }, content: {
                OrderCoffeeView()
            })
        }
    }
    
    private func showCoffeeOrderView() {
        self.isPresented = true
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = self.orderCoffeeViewModel.orders[index]
            self.orderCoffeeViewModel.deleteOrder(order: order)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentViewCell:View{
    let order:OrderViewModel
    
    private func getImageWithCoffeeName(name:String)->String{
        if name.lowercased() == "regular"{
            return "coffee"
        }else if name.lowercased() == "expresso"{
            return "expresso-coffee"
        }else{
            return "cappuccino-coffee"
        }
    }
    
  var body: some View {
    HStack{
        Image(self.getImageWithCoffeeName(name: order.name))
            .resizable()
            .frame(width: 80, height: 80)
            .cornerRadius(16)
        VStack(alignment: .leading){
           Text(order.name)
            .font(.title2)
                .padding([.leading], 25)
            HStack{
                Text(order.size)
                 .font(.title3)
                     .padding([.leading], 25)
                Text(order.price)
                 .font(.title3)
                     .padding([.leading], 2)
            }
        }
     }
    }
}
