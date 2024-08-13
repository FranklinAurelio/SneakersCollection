//
//  Modal_insert.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 13/08/24.
//

import Foundation

import SwiftUI
import Combine


struct ShowInputPopUp: View {
    @Binding var showModal: Bool
    @State private var model: String = ""
    @FocusState private var modelFieldIsFocused: Bool
    @State private var size: Int = 0
    @FocusState private var sizeFieldIsFocused: Bool
    @State private var price: Double = 0
    @FocusState private var priceFieldIsFocused: Bool
    @State private var detail: String = ""
    @FocusState private var detailFieldIsFocused: Bool
    @State private var brand: String = ""
    @FocusState private var brandFieldIsFocused: Bool
    @Environment(\.modelContext) private var modelContext
    //let numberFormatter: NumberFormatter
    //let mask:Mask?
    
    
    
    var body: some View {
        VStack(alignment: .center , spacing: 30
        ){
            Spacer()
            Text("Adicionar nova entrada")
                .foregroundStyle(Color.black)
            
            Spacer()
            Form {
                Section(header: Text("Modelo").foregroundStyle(Color.black)) {
                        TextField(
                            
                            "Modelo",
                            text: $model
                        )
                        .focused($modelFieldIsFocused)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(Color.black)
                        .keyboardType(.default)
                    }
                Section(header: Text("Preço").foregroundStyle(Color.black)) {
                    TextField(
                        "preço",
                        value: $price, formatter: NumberFormatter()
                    )
                    
                    .focused($priceFieldIsFocused)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundStyle(Color.black)
                    .keyboardType(.numberPad)
                }
                Section(header: Text("Tamanho").foregroundStyle(Color.black)) {
                    TextField(
                        "Tamanho",
                        value: $size, formatter: NumberFormatter()
                    )
                    
                    .focused($sizeFieldIsFocused)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundStyle(Color.black)
                    .keyboardType(.numberPad)
                }
                Section(header: Text("Detalhe").foregroundStyle(Color.black)) {
                    TextField(
                        
                        "Detalhe",
                        text: $detail
                    )
                    .focused($detailFieldIsFocused)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundStyle(Color.black)
                    .keyboardType(.default)
                }
                Section(header: Text("Marca").foregroundStyle(Color.black)) {
                    TextField(
                        
                        "Marca",
                        text: $brand
                    )
                    .focused($brandFieldIsFocused)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundStyle(Color.black)
                    .keyboardType(.default)
                }
            }
            .scrollContentBackground(.hidden)
            .textFieldStyle(.roundedBorder)
            .background(Color.white)
            Spacer()
            Button(action: {
                Task{
                    await addValue(model: model, price: price, size: size, descriptionDetail: detail, brand: brand)
                }
            }){
                HStack{
                    Text("Adicionar")
                    Image(systemName: "plus.circle")
                }
                
            }
            .padding()
            .background(Color.black)
            .clipShape(Capsule())
            .foregroundStyle(Color.white)
            //.shadow(color: Color(red: 0, green: 0.5, blue: 0.5), radius: 7)
        }
        .preferredColorScheme(.light)
        .textFieldStyle(.roundedBorder)
        .background(Color.white)
    }
    
    func addValue(model: String, price: Double, size: Int, descriptionDetail: String, brand: String)async{
            print("Value add")
            withAnimation {
                let newItem = Sneaker(model: model, price: price, size: size, descriptionDetail: descriptionDetail, brand: brand)
                modelContext.insert(newItem)
            }
            self.showModal.toggle()
        }
}
