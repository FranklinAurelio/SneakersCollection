//
//  SplashView.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State private var size = 0.5
    @State private var opacity = 0.0
    
    var body: some View {
        if self.isActive {
            ContentView()
        } else {
            VStack {
                // A imagem da splash screen em tela cheia
                Image("splashImage")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all) // Usando o modificador moderno
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        // Animação 1: Zoom e fade in suaves
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.size = 1.0
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                // Animação 2: Transição após um pequeno atraso
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
