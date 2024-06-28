//
//  ContentView.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    init() {
        UITableView.appearance().backgroundColor = .red
    }

    var body: some View {
       
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                       
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        GridCell()
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
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus.app.fill")
                          
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
      
        .accentColor(.black)
    
     
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
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
        .modelContainer(for: Item.self, inMemory: true)
}
