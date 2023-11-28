//
//  RecibosRecolector.swift
//  CaritasReliefAdmin
//
//  Created by J. Lugo on 10/11/23.
//

import SwiftUI
import Charts

struct RecibosRecolector: View {
    @State var token:String = ""
    @State var recolector:Recolector = Recolector(id: "1", nombres: "J", apellidos: "Martinez")
    @State var ChartData:EstadoRecibos = EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
    @State var CommentData:[Int] = [0,0,0,0,0,0]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let recibos:[recibosActivos] = getRecibos(token: token, recolector: recolector.id).recibosActivos
        
        NavigationStack{
            VStack{
                ZStack{
                    HeaderView(titulo: "\(recolector.nombres) \(recolector.apellidos)")
                    HStack{
                        Button(action: {
                                                // Handle the back action
                                                presentationMode.wrappedValue.dismiss()
                                            }) {
                                                Image(systemName: "chevron.left")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(.white)
                                            }
                                            .padding()
                    }.offset(x:-175,y:-15)
                }
                Text("Razones para no cobrar")
                    .font(.largeTitle)
                    .bold()
                Chart{
                    BarMark(x: .value("Estatus","No estaba"),y: .value("Recibos",CommentData[1]))
                    BarMark(x: .value("Estatus","Se mudó"),y: .value("Recibos",CommentData[2]))
                    BarMark(x: .value("Estatus","No quiere seguir ayudando"),y: .value("Recibos",CommentData[3]))
                    BarMark(x: .value("Estatus","Indispuesto"),y: .value("Recibos",CommentData[4]))
                    BarMark(x: .value("Estatus","Perdido"),y: .value("Recibos",CommentData[5]))
                }.frame(height: 200)
                List(recibos) { recibo in
                    NavigationLink{
                        CambiarRecibo(recibo: recibo, recolector: recolector, token:token)
                        }label:{
                            DonacionView(donante: recibo.donante, recibo: recibo)
                        }
                }.listStyle(.plain)
            }.onAppear(){
                ChartData = getChart(token: token, recolector: recolector.id)
                CommentData = getComentarios(tokenC: token, recolectorC: recolector.id)
            }
        }
        .navigationBarHidden(true)
    }
}

struct RecibosRecolector_Previews: PreviewProvider {
    static var previews: some View {
        RecibosRecolector()
    }
}
