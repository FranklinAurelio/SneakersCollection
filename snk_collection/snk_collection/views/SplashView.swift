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
    
    var body: some View{
        ZStack{
            if self.isActive {
                ContentView()
            }else{
                Rectangle()
                    .background(Color.black)
                Image("splashImage")
                    .resizable(resizingMode: .stretch)
                    .scaledToFill()
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider{
    static var previews: some View{
        SplashView()
    }
}
