//
//  CaritasSplashScreen.swift
//  CaritasReliefAdmin
//
//  Created by Alumno on 06/11/23.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size: CGFloat = 0.2
    @State private var opacity: Double = 0.0
    @State private var offsetY: CGFloat = 0
    let ColorP = Color(red: 0/255, green: 59/255, blue: 92/255)
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(ColorP)
                VStack {
                    Image("CaritasLogo")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 255)
                       
                }
                .scaleEffect(size)
                .opacity(opacity)
                .offset(y: offsetY)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.0
                        self.opacity = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.offsetY = -237.5 // Adjust this value based on how much you want the image to move up
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                          
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
