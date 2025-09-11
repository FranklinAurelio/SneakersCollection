//
//  GridCell.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import Foundation
import SwiftUI

struct GridCell: View {
    var itemPassed: ItemModel
    
    // A inicialização `init` é desnecessária se você apenas está atribuindo a variável
    // O SwiftUI já faz isso automaticamente.
    
    var body: some View {
        HStack(spacing: 10) {
            if let image = itemPassed.photo {
                Image(uiImage: UIImage(data: image) ?? .teste)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 60)
                    .clipShape(.rect(cornerRadius: 20))
                    //.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.primary, lineWidth: 2))
            } else {
                Image(.teste)
                    .resizable()
                    .frame(width: 100, height: 60)
                    .clipShape(.rect(cornerRadius: 20))
                    //.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.primary, lineWidth: 2))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Text(itemPassed.brand)
                        .foregroundStyle(Color.primary) // Alterado de Color.black para Color.primary
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("R$\(String(itemPassed.price))")
                        .foregroundStyle(Color.red) // Mantido o vermelho, pois é uma cor de destaque
                        .font(.caption)
                }
                
                Text(itemPassed.model)
                    .foregroundStyle(Color.primary) // Alterado de Color.black para Color.primary
                    .font(.caption)
                
                Divider()
                    .background(Color.secondary) // Alterado de Color.black para Color.secondary
            }
        }
        // Remova `.preferredColorScheme(.light)`. Isso força o modo claro.
        .background(Color(.secondarySystemBackground)) // Alterado de Color.white para uma cor de fundo adaptável
    }
}
