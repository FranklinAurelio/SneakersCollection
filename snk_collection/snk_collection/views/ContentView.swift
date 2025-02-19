//
//  ContentView.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import SwiftUI
import SwiftData
import Foundation


struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Sneaker]
    init() {
        UITableView.appearance().backgroundColor = .red
    }
    @State private var showingPopUp = false

    var body: some View {
       
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack(alignment: .leading){
                            Spacer()
                                .frame(height: 15)
                            if let imageView = item.photo {
                                Image(uiImage: UIImage(data: imageView) ?? .teste)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame( height: 250)
                                    .padding(20)
                                    .clipShape(.rect(cornerRadius: 20))
                            }else{Image(.teste)
                                    .resizable( resizingMode: .stretch)
                                    .frame( height: 250)
                                    .padding(20)
                                    .clipShape(.rect(cornerRadius: 20))}
                            
                            Spacer()
                                .frame(height: 15)
                            HStack{
                                Text("Modelo: ")
                                    .fontWeight(.bold)
                                    .padding([.leading],20)
                                Text(String(item.model))
                            }
                            Spacer()
                                .frame(height: 15)
                            HStack{
                                Text("Marca: ")
                                    .fontWeight(.bold)
                                    .padding([.leading],20)
                                Text(String(item.brand))
                            }
                            Spacer()
                                .frame(height: 15)
                            HStack(){
                                //Spacer(minLength: 10)
                                Text("Detalhes: ")
                                    .fontWeight(.bold)
                                    .padding([.leading],20)
                                Text(item.descriptionDetail)
                            }
                        
                            Spacer()
                                .frame(height: 15)
                            HStack{
                                Text("Tamanho: ")
                                    .fontWeight(.bold)
                                    .padding([.leading],20)
                                Text(String(item.size))
                            }
                            Spacer()
                                .frame(height: 15)
                            HStack{
                                Text("Preço: ")
                                    .fontWeight(.bold)
                                    .padding([.leading],20)
                                Text(String(item.price))
                            }
                            Spacer()
                            
                            
                            
                        }
                        
                    } label: {
                        GridCell(itemPassed: item)
                            .background()
                            .previewLayout(.fixed(width: 400, height: 90))
                          
                            
                        /*Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))*/
                    }
                    
                }
                
                .onDelete(perform: deleteItems)
                .listRowBackground(Color.white)
                .listRowSpacing(10)
                
            }
         
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                    
                }
                ToolbarItem {
                    Button(action: 
                            
                            addItem
                    ) {
                        Label("Add Item", systemImage: "plus.app.fill")
                          
                    }
                }
            }
            .background(Color.white)
            .sheet(isPresented: $showingPopUp, content: {
                ShowInputPopUp(showModal: self.$showingPopUp)
            })
        } detail: {
            Text("Select an item")
        }
      
        .accentColor(.black)
     
    }
    
        

    private func addItem() {
        showingPopUp.toggle()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}
    

#Preview {
    ContentView()
        .modelContainer(for: Sneaker.self, inMemory: true)
}
