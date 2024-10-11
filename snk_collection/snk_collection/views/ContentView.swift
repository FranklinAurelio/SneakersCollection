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
                        VStack{
                            Spacer()
                                .frame(height: 15)
                            Image(.teste)
                                .resizable( resizingMode: .stretch)
                                .frame( height: 250)
                                .padding(20)
                                .clipShape(.rect(cornerRadius: 20))
                            Spacer()
                                .frame(height: 15)
                            HStack{
                                Text("Detalhes: ")
                                    .fontWeight(.bold)
                                Text(item.descriptionDetail)
                            }
                            Spacer()
                                .frame(height: 15)
                            HStack{
                                Text("Tamanho: ")
                                    .fontWeight(.bold)
                                Text(String(item.size))
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
