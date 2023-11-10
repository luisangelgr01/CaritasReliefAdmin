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
    var body: some View {
        let data = getRecolectores(token: token)
        VStack{
            HeaderView(titulo: "Dashboard")
        
            Text("Rendimiento actual")
                .font(.largeTitle)
                .bold()
            Chart{
                BarMark(x: .value("Recolector","JMartinez"),y: .value("Recibos cobrados",12))
                BarMark(x: .value("Recolector","XXXXXXX"),y: .value("Recibos cobrados",10))
                BarMark(x: .value("Recolector","XXXXXXX1"),y: .value("Recibos cobrados",15))
            }.frame(height: 200)
            List(data.recolectores){
                recolector in
                RecolectorCard(recolector: recolector)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            Spacer()
        }.onAppear(){
            
        }
    }
}

struct MainDashboard_Previews: PreviewProvider {
    static var previews: some View {
        MainDashboard()
    }
}
