//
//  DonacionesView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct DonacionesView: View {
    @State var token:String
    @State var recolector:Int
    @State private var visited = true
    
    
    var body: some View {
        let listaDonantes = getDonantes(token: token, idRecolector: recolector)
        NavigationStack{
            VStack{
                HeaderView(titulo: "DONACIONES")
                /*
                Picker("Visita", selection: $visited) {
                    Text("Visitado")
                        .tag(true)
                    
                    Text("No visitado").tag(false)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                */
                
                List(listaDonantes){donanteItem in
                    NavigationLink{
                        
                        DetalleView(donante: donanteItem,recolector:recolector,token: token)
                        
                    }label:{
                        DonacionView(donante: donanteItem)
                    }
        
                }
                .listStyle(.plain)
                
                
                
            }
        }
    }
}

struct DonacionesView_Previews: PreviewProvider {
    static var previews: some View {
        DonacionesView(token: "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJKTWFydGluZXoxMDAiLCJpYXQiOiIxMC8yMi8yMDIzIDAwOjA5OjAxIiwianRpIjoiMzNkYzMzNzgtMDBlNy00ZmNhLWEwMzctMmMwMTkyMGRjYmQyIiwicm9sZSI6InVzZXIiLCJleHAiOjE2OTgwMTk3NDF9.3hoBmCh9owaSJADDluntMDCIbdj9zQKm9XCpG6yzdHs",recolector: 1)
    }
}
