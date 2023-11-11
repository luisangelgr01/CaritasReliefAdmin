//
//  MainDashboard.swift
//  CaritasReliefAdmin
//
//  Created by J. Lugo on 09/11/23.
//

import SwiftUI
import Charts

struct MainDashboard: View {
    @State var token:String = ""
    @State private var ChartData:EstadoRecibos = EstadoRecibos(cobradosFallidos: 0, pendiente: 0, cobrados: 0)
    var body: some View {
        let data = getRecolectores(token: token)
        NavigationStack{
            VStack{
                HeaderView(titulo: "Dashboard")
                TabView{
                    VStack{
                        Text("Rendimiento actual")
                            .font(.largeTitle)
                            .bold()
                        Chart{
                            BarMark(x: .value("Estatus","Fallido"),y: .value("Recibos",ChartData.cobradosFallidos)).foregroundStyle(.red)
                            BarMark(x: .value("Estatus","Pendiente"),y: .value("Recibos",ChartData.pendiente)).foregroundStyle(.yellow)
                            BarMark(x: .value("Estatus","Cobrado"),y: .value("Recibos",ChartData.cobrados)).foregroundStyle(ColorPrincipal)
                        }.frame(height: 200)
                    }
                    VStack{
                        Text("Recolectado")
                            .font(.largeTitle)
                            .bold()
                        Chart(data.recolectores){
                            recolector in
                            BarMark(x: .value("Recolector",recolector.nombres), y: .value("Cobrado",getTotalCobrado(token: token, repartidor: recolector.id)))
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                List(data.recolectores){
                    recolector in
                    NavigationLink{
                        RecibosRecolector(token: token, recolector: recolector)
                    }label:{
                        RecolectorCard(recolector: recolector)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                Spacer()
            }.onAppear(){
                ChartData = getDashChart(token: token)
            }
        }.navigationTitle("Dashboard")
            .navigationBarHidden(true)
            
    }
}

struct MainDashboard_Previews: PreviewProvider {
    static var previews: some View {
        MainDashboard()
    }
}
