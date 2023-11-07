//
//  DetalleView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct DetalleView: View {
    var donante:donantesHoy
    var recolector:Int
    @State var token:String
        var body: some View {
            var Donante = getRecibos(token: token, donante: donante.id, recolector: 1)
            var listaRecibos = Donante[0].recibosActivos
        VStack(alignment: .center){
            HeaderView(titulo: "\(donante.nombres) \(donante.apellidos)")
            VStack{
                HStack(alignment: .center){
                    Image(systemName: "mappin.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(ColorPrincipal)
                        
                    Text(donante.direccion)
                        .font(.title)
                        .padding(.leading, 10)
                    Spacer()
                }.padding(.bottom, 15)
                HStack(alignment: .center){
                    Image(systemName: "iphone.gen3")
                        .font(.largeTitle)
                        .foregroundColor(ColorPrincipal)
                        
                    
                    Text(donante.telCelular)
                        .font(.title)
                        .padding(.leading, 10)
                    Spacer()
                    
                }.padding(.bottom, 15)
                
                HStack(alignment: .center){
                    Image(systemName: "phone.fill")
                        .font(.largeTitle)
                        .foregroundColor(ColorPrincipal)
                    
                    Text(donante.telCasa)
                        .font(.title)
                        .padding(.leading, 10)
                    Spacer()
                    
                }.padding(.bottom, 15)
                
                
                
            }.padding(.horizontal, 30)
            List(listaRecibos){recibo in
                ReciboView(recibo: recibo,token: token)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        }
    }
}

struct DetalleView_Previews: PreviewProvider {
    static var previews: some View {
        @State var donante:donantesHoy = donantesHoy(id: "1", nombres: "", apellidos: "", direccion: "", telCelular: "", telCasa: "", cantidadRecibosActivos: 1)
        DetalleView(donante: donante,recolector: 1, token: "")
    }
}
