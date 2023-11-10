//
//  ReciboView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI
/*
struct ReciboView: View {
    @State var recibo:recibosActivos
    @State private var confirmarAccion:Bool = false
    @State private var errorAlert:Bool = false
    @State private var comentarios:Bool = false
    var token:String
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            
                            Text("#\(recibo.id)")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            
                            Text("$\(Int(recibo.cantidad))")
                                .font(.title)
                                .foregroundColor(Color(red: 0.003, green: 0.208, blue: 0.327))
                            
                            
                            
                                .font(.title)
                                .foregroundColor(Color(red: 0.003, green: 0.208, blue: 0.327))
                            
                            
                        }.padding(.bottom, 8)
                        
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    HStack{
                        Spacer()
                        Button(action: comentariosAct){
                            
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding(.horizontal,50 )
                        }.buttonStyle(.borderedProminent)
                            .tint(.red)
                            .navigationDestination(isPresented: $comentarios){
                                ComentariosView(recibo: recibo.id, token: token)
                            }
                        Button(action: confirmar){
                            
                            Image(systemName: "checkmark")
                                .padding(.horizontal,50 )
                                .font(.title)
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(ColorPrincipal)
                        .alert("Continuar?",isPresented: $confirmarAccion){
                            Button("SI"){
                                let response = cobrarRecibo(recibo: recibo.id, token: token)
                                if(response == false){
                                    errorAlert.toggle()
                                }
                            }
                            Button("NO"){}
                        }
                        
                        
                        
                        
                        Spacer()
                        
                    }
                }
                .padding(.top, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                )
                
                .background(.white)
                
            }
            
        }
    }
    
    func confirmar(){
        confirmarAccion.toggle()
    }
    func comentariosAct(){
        comentarios.toggle()
    }
}

struct ReciboView_Previews: PreviewProvider {
    static var previews: some View {
        ReciboView(recibo: recibosActivos(cantidad: 200.0, id: "1"),token: "")
    }
}
*/
