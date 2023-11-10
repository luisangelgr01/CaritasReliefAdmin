//
//  RecolectorCard.swift
//  CaritasReliefAdmin
//
//  Created by J. Lugo on 09/11/23.
//

import SwiftUI

struct RecolectorCard: View {
    @State var recolector:Recolector = Recolector(id: "1", nombres: "J", apellidos: "Martinez")
    var body: some View {
        VStack(alignment:.leading){
            HStack(alignment:.center){
                Image(systemName: "person.fill")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25.0)
                    .foregroundColor(ColorPrincipal)
                Text("\(recolector.nombres) \(recolector.apellidos)")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Image(systemName: "grid.circle.fill")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25.0)
                    .foregroundColor(ColorPrincipal)
                Text("\(recolector.id)")
                    .font(.title)
                    .bold()
            }
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct RecolectorCard_Previews: PreviewProvider {
    static var previews: some View {
        RecolectorCard()
    }
}
