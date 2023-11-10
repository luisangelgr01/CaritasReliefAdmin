//
//  DonacionView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI
/*
struct DonacionView: View {
    var donante: donantesHoy
    @State var barColor:Color = .red
    var body: some View {
    
        VStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        //Nombre de donante
                        Text("\(donante.nombres) \(donante.apellidos)")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        //Si hay mas de un recibo mostrar cantidad de recibos si solo hay uno mostrar la cantidad de donacion
                        
                        
                        //cantidad de donacion
                        /*
                        Text("$200")
                            .font(.title)
                            .foregroundColor(Color(red: 0.003, green: 0.208, blue: 0.327))
                        */
                        //numero de recibos
                        HStack{
                            Text("\(donante.cantidadRecibosActivos)")
                            Image(systemName: "doc.plaintext")
                            
                            
                        }
                        .font(.title)
                        .foregroundColor(Color(red: 0.003, green: 0.208, blue: 0.327))
                        
                        
                    }.padding(.bottom, 8)
                    
                    //direccion
                    Text(donante.direccion)
                        .font(.title2)
                }
                .padding(.horizontal, 20)
                //Barra de estado
                //aqui se tiene que cambiar el color de lo0s dos rectangulos para actualizar la barra de estado
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(barColor)
                        .frame(width: .infinity, height: 10)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(barColor)
                        .frame(width: .infinity, height: 20)
                }
                    
                
            }
            .padding(.top, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
            )
            
            .background(.white)
            .onAppear(){
                if(donante.cantidadRecibosActivos == 0){
                    barColor = .green
                }else{
                    barColor = .red
                }
            }
            
            
            
        }
    }
}

struct DonacionView_Previews: PreviewProvider {
    static var previews: some View {
        @State var donante:donantesHoy = donantesHoy(id: "", nombres: "", apellidos: "", direccion: "", telCelular: "", telCasa: "", cantidadRecibosActivos: 1)
        DonacionView(donante: donante)
    }
}
*/
