//
//  DonacionView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct DonacionView: View {
    var donante: Donante
    var recibo: recibosActivos
    @State var barColor:Color = .red
    @State var fontColor:Color = .black
    var body: some View {
    
        VStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        //Nombre de donante
                        Text("\(donante.nombres) \(donante.apellidos)")
                            .font(.title)
                            .bold()
                            .foregroundColor(fontColor)
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
                            Text("#\((String(format: "%06d", Int(recibo.id)!)))")
                                
                            
                        }
                        .font(.title)
                        .foregroundColor(fontColor)
                    
                        
                        
                    }.padding(.bottom, 8)
                    
                    //direccion
                    Text(recibo.comentarios)
                        .font(.title2)
                        .foregroundColor(fontColor)
                    
                    
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
                if(recibo.cobrado == 1){
                    barColor = .green
                    fontColor = .gray
                }else if(recibo.cobrado == 0){
                    barColor = .red
                    fontColor = .gray
                }else{
                    barColor = .yellow
                    fontColor = .black
                }
            }
            
            
            
        }
    }
}

struct DonacionView_Previews: PreviewProvider {
    static var previews: some View {
        @State var donante:Donante = Donante(id: "", nombres: "", apellidos: "", direccion: "", telCelular: "", telCasa: "")
        @State var recibo:recibosActivos = recibosActivos( cantidad: 200.0, id: "1", cobrado: 2, comentarios: "", donante: donante)
        DonacionView(donante: donante, recibo: recibo)
    }
}
