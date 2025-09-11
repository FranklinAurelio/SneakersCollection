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
    
    // Remova a linha 'UITableView.appearance().backgroundColor = .red'
    // A melhor prática em SwiftUI é evitar manipular UIKit 'appearance'
    // diretamente, pois isso pode causar comportamento inesperado.
    
    @State private var showingPopUp = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack(alignment: .leading) {
                            Spacer()
                                .frame(height: 15)
                            
                            // Use uma View adaptável para a imagem em vez de lógica dentro da view
                            ItemDetailView(item: item)

                            Spacer()
                                .frame(height: 15)
                            
                            // Use 'Color.primary' para o texto
                            TextDetailsView(item: item)
                        }
                        .background(Color(.systemBackground)) // Garante que o fundo da página de detalhe se adapta
                    } label: {
                        GridCell(itemPassed: item)
                            .background(Color(.secondarySystemBackground)) // Use uma cor de fundo adaptável para as células da lista
                    }
                }
                .onDelete(perform: deleteItems)
                // Remova .listRowBackground(Color.white) e .listRowSpacing(10)
                // A cor de fundo padrão da lista já se adapta.
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
            // Remova .background(Color.white)
            // O fundo da NavigationSplitView já se adapta.
            .sheet(isPresented: $showingPopUp, content: {
                ShowInputPopUp(showModal: self.$showingPopUp)
            })
        } detail: {
            Text("Select an item")
        }
        .accentColor(.primary) // Use .primary ou a cor da sua marca para o acento
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
