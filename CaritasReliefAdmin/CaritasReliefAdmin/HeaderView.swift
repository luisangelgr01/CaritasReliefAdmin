//
//  HeaderView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct HeaderView: View {
    var titulo = ""
    var body: some View {
        VStack {
            
            Text(titulo)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .bold()
                .frame(width:1000)
                .padding(.bottom, 30)
                .padding(.top, 80)
                .background(ColorSecundario)
                .foregroundColor(.white)
                
                
            
        }
        
        .edgesIgnoringSafeArea(.top)
        .padding(.bottom, -40)
    
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let titulo = ""
        HeaderView(titulo: titulo)
    }
}
