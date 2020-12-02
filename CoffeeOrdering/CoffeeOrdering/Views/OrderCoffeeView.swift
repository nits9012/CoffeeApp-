//
//  OrderCoffeeView.swift
//  CoffeeOrdering
//
//  Created by Nitin Bhatt on 11/7/20.
//

import SwiftUI

struct OrderCoffeeView: View {
   
    @ObservedObject private var orderCoffeeViewModel = OrderCoffeeListViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List{
            ForEach(orderCoffeeViewModel.coffeeList, id: \.name) { value in
                OrderCoffeeCell(coffee: value, selection:self.$orderCoffeeViewModel.coffeeName)
            }
        }.frame(height:300)
        
        Section(header: Text("SELECT SIZE").font(.title),footer:Text(self.orderCoffeeViewModel.totalPrice).font(.title2), content: {
            Picker("",selection: self.$orderCoffeeViewModel.size) {
                Text("Small").tag("Small")
                Text("Medium").tag("Medium")
                Text("Large").tag("Large")
                Text("Extra-Large").tag("Extra-Large")
            }.pickerStyle(SegmentedPickerStyle())
        })
        
        Button("Place Order") {
            orderCoffeeViewModel.saveOrder()
            self.presentationMode.wrappedValue.dismiss()
        }.padding().frame(height:30).background(Color.red).foregroundColor(Color.white).font(.title3)
        Spacer()
    }
    
}

struct OrderCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCoffeeView()
    }
}

struct OrderCoffeeCell:View{
    let coffee:CoffeeViewModel
    @Binding var selection: String
   
    var body: some View {
        HStack{
            Image(coffee.image)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(16)
            Text(coffee.name)
                .font(.title3)
                .padding([.leading],25)
            Spacer()
            Image(systemName: self.selection == coffee.name ? "checkmark" : "").padding()
        }.onTapGesture{
            self.selection = self.coffee.name
        }
    }
}
