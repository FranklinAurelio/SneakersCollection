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
     
        VStack(alignment: .leading){
            HStack(spacing: 10){
                Text("Text")
                    
                    .foregroundStyle(Color.black)
                    .font(.caption)
                
                Spacer()
                Text("R$\(String("2"))"
                )
                .foregroundStyle(Color.red)
                .font(.caption)
                
                
            }
            Text("Text Description")
                .foregroundStyle(Color.black)
                .font(.caption)
            Divider()
                .background(Color.black)
        }
        .preferredColorScheme(.light)
        .background(Color.white)
        
    }
}
