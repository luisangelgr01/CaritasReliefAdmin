//
//  CambiarRecibo.swift
//  CaritasReliefAdmin
//
//  Created by J. Lugo on 10/11/23.
//

import SwiftUI

struct CambiarRecibo: View {
    @Environment(\.presentationMode) var presentationMode
    @State var recibo:recibosActivos = recibosActivos(cantidad: 100, id: "1", cobrado: 2, donante: Donante(id: "a", nombres: "a", apellidos: "a", direccion: "", telCelular: "a", telCasa: "a"))
    @State private var data:[Recolector] = []
    @State var recolector:Recolector = Recolector(id: "1", nombres: "Jose", apellidos: "Martinez")
    @State private var modify:Bool = false
    @State private var selection = ""
    @State var token:String = ""
    @State private var alert:Bool = false
    @State private var done:Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    HeaderView(titulo: "Reasignar recibo")
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
                Spacer()
                VStack(alignment: .leading){
                    Text("Donación:").font(.largeTitle)
                    DonacionView(donante: recibo.donante, recibo: recibo)
                    HStack{
                        
                        Toggle( isOn:$modify){
                            Text("Reasignar recibo")
                                .font(.title)
                        }
                    }.padding(.vertical, 15)
                    if(modify){
                        Picker(selection: $selection){
                            ForEach(data) { datum in
                                Text("\(datum.nombres) \(datum.apellidos)").tag(datum.id)
                            }
                        }label:{
                            
                        }.pickerStyle(.wheel)
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action:({alert.toggle()})){
                                HStack{
                                    Spacer()
                                    Text("Confirmar")
                                        .font(.largeTitle)
                                    Spacer()
                                }.padding(.vertical,5)
                            }.buttonStyle(.borderedProminent)
                                .alert("¿Desea cambiar el recolector del recibo?", isPresented: $alert){
                                    Button("NO"){
                                        
                                    }
                                    Button("SI"){
                                        let x = reasignarRecibo(token: token, recolector: selection, recibo: recibo.id)
                                        if(x.transferirARecolector == "OK"){
                                            done.toggle()
                                        }
                                    }
                                }
                                .alert("Recibo reasignado exitosamente",isPresented:$done){
                                    Button("OK"){
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                .tint(ColorPrincipal)
                            
                            Spacer()
                        }
                    }
                }
                Spacer()
            }.onAppear(){
                data = getRecolectores(token: token).recolectores
                selection = recolector.id
            }
        }.navigationBarHidden(true)
        
    }
}

struct CambiarRecibo_Previews: PreviewProvider {
    static var previews: some View {
        CambiarRecibo()
    }
}
