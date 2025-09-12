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
    @Query private var items: [ItemModel]
    
    @State private var showingPopUp = false
    
    private var groupedItems: [String: [ItemModel]] {
        Dictionary(grouping: items) { item in
            // IMPORTANTE: Assumimos que 'ItemModel' tem uma propriedade 'category: String'
            return item.category
        }
    }
    
    var body: some View {
        NavigationSplitView {
            if groupedItems.isEmpty {
                ContentUnavailableView("Adicione seu primeiro item",
                                       systemImage: "list.clipboard")
                .toolbar {
                    // O EditButton foi removido, pois não é compatível com DisclosureGroup
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus.app.fill")
                        }
                    }
                }
                .sheet(isPresented: $showingPopUp, content: {
                    ShowInputPopUp(showModal: self.$showingPopUp)
                })
            } else {
                List {
                    // Itera sobre as chaves e valores do dicionário
                    ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                        
                        // Substituímos o Section por um DisclosureGroup
                        DisclosureGroup(category) {
                        
                            ForEach(groupedItems[category]!, id: \.self) { item in
                                NavigationLink {
                                    VStack(alignment: .leading) {
                                        Spacer().frame(height: 15)
                                        ItemDetailView(item: item)
                                        Spacer().frame(height: 15)
                                        TextDetailsView(item: item)
                                    }
                                    .background(Color(.systemBackground))
                                } label: {
                                    GridCell(itemPassed: item)
                                        .background(Color(.secondarySystemBackground))
                                }
                                // Adiciona um menu de contexto para a exclusão
                                .contextMenu {
                                    Button(role: .destructive) {
                                        deleteItem(item)
                                    } label: {
                                        Label("Excluir", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    // O EditButton foi removido, pois não é compatível com DisclosureGroup
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus.app.fill")
                        }
                    }
                }
                .sheet(isPresented: $showingPopUp, content: {
                    ShowInputPopUp(showModal: self.$showingPopUp)
                })
            }
            
        } detail: {
            Text("Select an item")
        }
        .accentColor(.primary)
    }
    
    private func addItem() {
        showingPopUp.toggle()
    }
    
    // Função de exclusão simplificada, já que o contextMenu passa o item
    private func deleteItem(_ item: ItemModel) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

// Subview para a imagem para maior organização
struct ItemDetailView: View {
    var item: ItemModel
    var body: some View {
        VStack { // Adiciona um VStack para espaçamento
            if let imageData = item.photo, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .padding(20)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                Image(.teste)
                    .resizable(resizingMode: .stretch)
                    .frame(height: 250)
                    .padding(20)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(.bottom, 20) // Adiciona espaço na parte inferior da imagem
    }
}

// Subview para os detalhes de texto
struct TextDetailsView: View {
    var item: ItemModel
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Modelo: ")
                    .fontWeight(.bold)
                Text(String(item.model))
            }
            HStack {
                Text("Marca: ")
                    .fontWeight(.bold)
                Text(String(item.brand))
            }
            HStack {
                Text("Detalhes: ")
                    .fontWeight(.bold)
                Text(item.descriptionDetail)
            }
            HStack {
                Text("Tamanho: ")
                    .fontWeight(.bold)
                Text(String(item.size))
            }
            HStack {
                Text("Preço: ")
                    .fontWeight(.bold)
                // Usando uma string formatada para adicionar o R$
                Text("R$\(String(format: "%.2f", item.price))")
            }
        }
        .padding(.leading, 20)
        .foregroundColor(.primary)
    }
}
    

#Preview {
    ContentView()
        .modelContainer(for: ItemModel.self, inMemory: true)
}
