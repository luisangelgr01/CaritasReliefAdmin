//
//  DetalleView.swift
//  ProyectoCaritas
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

struct DetalleView: View {
    var donante:Donante
    var recibo:recibosActivos
    var recolector:Int
    @State var token:String
        var body: some View {
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
            .padding(.top, 20)
            if(recibo.cobrado == 2){
                ReciboView(recibo: recibo,token: token)
                    .padding(.horizontal, 20)
            }else{
                Text("No tiene cobros pendientes")
                    .font(.title)
            }
            Spacer()
        }
    }
}

struct DetalleView_Previews: PreviewProvider {
    static var previews: some View {
        @State var donante:Donante = Donante(id: "1", nombres: "", apellidos: "", direccion: "", telCelular: "", telCasa: "")
        @State var recibo:recibosActivos = recibosActivos( cantidad: 200.0, id: "1", cobrado: 2, comentario: "" ,donante: donante)
        DetalleView(donante: donante, recibo: recibo, recolector: 1 ,token: "")
    }
}
