//
//  ContentView.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashScreenPresented = true
    
    var body: some View {

 ZStack {
                if isSplashScreenPresented {
                    SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    isSplashScreenPresented = false
                                }
                            }
                        }
                } else {
                    LoginWindow()
                    Link("link", destination: URL(string:"https://drive.google.com/drive/folders/1GF2v-bt427Cy3BLcA-d7ADys_6mMXa50?usp=sharing" )!)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
