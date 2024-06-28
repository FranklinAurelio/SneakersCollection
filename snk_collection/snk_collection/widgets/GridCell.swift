//
//  GridCell.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import Foundation
import SwiftUI

struct GridCell: View {
    
   
    var body: some View {
        HStack(spacing: 10){
            Image(.teste)
                .resizable()
                .frame(width: 100, height: 60)
                
                .clipShape(.rect(cornerRadius: 20))
                //.overlay(RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 2))
                
            VStack(alignment: .leading, spacing: 10){
                HStack(spacing: 10){
                    Text("Jordan")
                        
                        .foregroundStyle(Color.black)
                        .font(.caption)
                    
                    Spacer()
                    Text("R$\(String("1200"))"
                    )
                    .foregroundStyle(Color.red)
                    .font(.caption)
                    
                    
                }
                Text("Spyzik year of dragon")
                    .foregroundStyle(Color.black)
                    .font(.caption)
                Divider()
                    .background(Color.black)
            }
            .preferredColorScheme(.light)
            .background(Color.white)
            
            
        }
        
    }
        
}
