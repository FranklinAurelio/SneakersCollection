//
//  Modal_insert.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 13/08/24.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

struct ShowInputPopUp: View {
    @State private var selectedItem: PhotosPickerItem?
    @State var image: Image?
    @State var imageData: Data?
    
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    
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
    @State private var photo: Data? = nil
    @FocusState private var photoFieldIsFocused: Bool
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Spacer()
            Text("Adicionar nova entrada")
                .foregroundStyle(Color.primary) // Alterado para a cor primária
            
            Spacer()
            
            Form {
                Section(header: Text("Modelo").foregroundStyle(Color.primary)) { // Alterado para a cor primária
                    TextField(
                        "Modelo",
                        text: $model
                    )
                    .focused($modelFieldIsFocused)
                    // Removido o .border(Color.black), pois Form já tem um estilo padrão
                    // que se adapta.
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)
                }
                
                Section(header: Text("Preço").foregroundStyle(Color.primary)) { // Alterado para a cor primária
                    TextField(
                        "preço",
                        value: $price, formatter: NumberFormatter()
                    )
                    .focused($priceFieldIsFocused)
                    // Removido o .border(Color.black)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                }
                
                Section(header: Text("Tamanho").foregroundStyle(Color.primary)) { // Alterado para a cor primária
                    TextField(
                        "Tamanho",
                        value: $size, formatter: NumberFormatter()
                    )
                    .focused($sizeFieldIsFocused)
                    // Removido o .border(Color.black)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                }
                
                Section(header: Text("Detalhe").foregroundStyle(Color.primary)) { // Alterado para a cor primária
                    TextField(
                        "Detalhe",
                        text: $detail
                    )
                    .focused($detailFieldIsFocused)
                    // Removido o .border(Color.black)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)
                }
                
                Section(header: Text("Marca").foregroundStyle(Color.primary)) { // Alterado para a cor primária
                    TextField(
                        "Marca",
                        text: $brand
                    )
                    .focused($brandFieldIsFocused)
                    // Removido o .border(Color.black)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.default)
                }
            }
            .scrollContentBackground(.hidden)
            // Removido o .textFieldStyle(.roundedBorder) daqui, pois já está nos TextFields.
            .background(Color(.systemBackground)) // Alterado para uma cor de fundo adaptável
            
            Spacer()
            
            PhotosPicker("Inserir imagen", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem) {
                    Task {
                        if let transferrable = try? await selectedItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: transferrable) {
                                self.image = Image(uiImage: uiImage)
                                self.imageData = transferrable
                            }
                        }
                    }
                }
            
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150) // Adicionando uma altura fixa para a imagem
            }
            
            HStack {
                Button(action: {
                    Task {
                        await addValue(model: model, price: price, size: size, descriptionDetail: detail, brand: brand, picture: imageData)
                    }
                }) {
                    HStack {
                        Text("Adicionar")
                        Image(systemName: "plus.circle")
                    }
                }
                .padding()
                .background(Color.accentColor) // Usando a cor de acento do sistema
                .clipShape(Capsule())
                .foregroundStyle(Color(.secondarySystemBackground)) // Alterado para uma cor de texto adaptável
            }
            .padding(.horizontal, 20)
        }
        // Removido `.preferredColorScheme(.light)`
        // Removido o `.background(Color.white)` redundante
    }
    
    func addValue(model: String, price: Double, size: Int, descriptionDetail: String, brand: String, picture: Data?) async {
        withAnimation {
            let newItem = ItemModel(model: model, price: price, size: size, descriptionDetail: descriptionDetail, photo: picture, brand: brand)
            modelContext.insert(newItem)
        }
        self.showModal.toggle()
    }
}
