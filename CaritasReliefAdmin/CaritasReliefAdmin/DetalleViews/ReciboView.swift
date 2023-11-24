//
//  ReciboView.swift
//  ProyectoCaritas
//
//  Created by Alumno on 20/10/23.
//

import SwiftUI

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
                                .padding(.leading, 20)
                            Spacer()
                            
                            Text("$\(Int(recibo.cantidad))")
                                .font(.title)
                                .foregroundColor(Color(red: 0.003, green: 0.208, blue: 0.327))
                     
                                .font(.title)
                                .padding(.trailing, 20)
                                .foregroundColor(Color(red: 0.003, green: 0.208, blue: 0.327))
                            
                        }.padding(.bottom, 8)
                        
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    HStack{
                        Spacer()
                        
                        Button(action: confirmar){
                            
                            Text("Sí")
                                .padding(.horizontal,50 )
                                .padding(.vertical, 20)
                                .font(.title)
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(ColorPrincipal)
                        .alert("¿Deseas marcar el recibo como cobrado?",isPresented: $confirmarAccion){
                            Button("Si"){
                                /*let response = cobrarRecibo(recibo: recibo.id, token: token)
                                if(response == false){
                                    errorAlert.toggle()
                                }
                                
                                */
                            }
                            Button("No"){}
                                 
                        }
                        
                        Button(action: comentariosAct){
                            
                            Text("No")
                                .font(.title)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 20)
                        }.buttonStyle(.borderedProminent)
                            .tint(.red)
                            .navigationDestination(isPresented: $comentarios){
                                ComentariosView(recibo: recibo.id, token: token)
                            }
                        
                        
                        Spacer()
                        
                    }
                    .padding(.bottom, 20)
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
        ReciboView(recibo: recibosActivos(cantidad: 200.0, id: "1", cobrado: 2, comentarios: "" ,donante: Donante(id: "", nombres: "", apellidos: "", direccion: "", telCelular: "", telCasa: "")), token:"")
    }
}
