//
//  LoginWindow.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct LoginWindow: View {
    /*
    guard let customFont = UIFont(name: "CaritasFont", size: UIFont.labelFontSize) else{fatalError("fuckOff")}
     */
    
    let ColorP = Color(red: 0/255, green: 59/255, blue: 92/255)
    let ColorS = Color(red: 0/255, green: 156/255, blue: 166/255)
    @State private var IdUsername: String = ""
    @State private var IdPassword: String = ""
    @State private var loginerror:Bool = false
    @State private var authorized:Bool = false
    @State private var token:String = ""
    @State private var recolector:Int = 0
    
    // Offsets for animation
    @State private var caritas40Offset: CGFloat = UIScreen.main.bounds.width
    @State private var usernameOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var passwordOffset: CGFloat = UIScreen.main.bounds.width
    @State private var buttonOffset: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(ColorP)
                VStack{
                    
                    
                    Image("CaritasLogo")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 80)
                        .frame(width: 255)
                    Spacer()
                    /*
                     Image("Caritas40")
                     .offset(x: caritas40Offset)
                     .onAppear {
                     withAnimation(.spring().delay(0.2)) {
                     caritas40Offset = 0
                     }
                     }
                     */
                    
                    Text("Cáritas Relief Manager")
                        .font(.custom("CaritasFont", size: 40))
                        .foregroundColor(.white)
                        .offset(x: caritas40Offset)
                        .onAppear {
                            withAnimation(.spring().delay(0.2)) {
                                caritas40Offset = 0
                            }
                        }
                    
                    Spacer()
                    TextField("Username", text: $IdUsername)
                        .font(.title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 60)
                        .offset(x: usernameOffset)
                        .onAppear {
                            withAnimation(.spring().delay(0.4)) {
                                usernameOffset = 0
                            }
                        }
                    
                    SecureField("Password", text: $IdPassword)
                        .font(.title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 60)
                        .padding(.bottom, 10)
                        .offset(x: passwordOffset)
                        .onAppear {
                            withAnimation(.spring().delay(0.6)) {
                                passwordOffset = 0
                            }
                        }
                        .textContentType(.password)
                    
                    Button(action:{
                        let x = login(username: IdUsername, password: IdPassword)
                        if(x != nil){
                            Usuario = x!
                            print(Usuario.token)
                            token = x!.token
                            recolector = x!.user[0]
                            authorized.toggle()
                        }else{
                            loginerror.toggle()
                        }
                    }){
                        Text("Acceder")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 76)
                            .font(.title)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 100)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(ColorS)
                    .offset(y: buttonOffset)
                    .alert(isPresented:$loginerror){
                        Alert(title: Text("Usuario o contraseña incorrectos"))
                    }
                    .navigationDestination( isPresented: $authorized){
                        MainDashboard(token: token)
                    }
                    .onAppear {
                        withAnimation(.spring().delay(0.8)) {
                            buttonOffset = 0
                        }
                    }
                    
                    Spacer()
                }
            }
            }
        }
}

struct LoginWindow_Previews: PreviewProvider {
    static var previews: some View {
        LoginWindow()
    }
}
