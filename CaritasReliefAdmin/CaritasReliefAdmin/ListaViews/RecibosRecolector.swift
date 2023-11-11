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
                Text("Rendimiento actual")
                    .font(.largeTitle)
                    .bold()
                Chart{
                    BarMark(x: .value("Estatus","Fallido"),y: .value("Recibos",ChartData.cobradosFallidos)).foregroundStyle(.red)
                    BarMark(x: .value("Estatus","Pendiente"),y: .value("Recibos",ChartData.pendiente)).foregroundStyle(.yellow)
                    BarMark(x: .value("Estatus","Cobrado"),y: .value("Recibos",ChartData.cobrados)).foregroundStyle(ColorPrincipal)
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
