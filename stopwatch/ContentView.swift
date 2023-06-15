//
//  ContentView.swift
//  stopwatch
//
//  Created by Shelley Timmins on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.accentColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Welcome to your stopwatch")
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text("00:00:00")
                    .padding()
                    .font(.system(size: 40, weight: .bold))
                Spacer()
                HStack {
                    Text("Start")
                        .padding()
                        .font(.system(size: 24, weight: .bold))
                        .background(Color.green)
                        .cornerRadius(10)
                    Text("Reset")
                        .padding()
                        .font(.system(size: 24, weight: .bold))
                        .background(Color.red)
                        .cornerRadius(10)
                    Text("Lap")
                        .padding()
                        .font(.system(size: 24, weight: .bold))
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
