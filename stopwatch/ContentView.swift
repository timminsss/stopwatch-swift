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
            Color.white
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
                    Spacer()
                    Button {
                        print("start")
                    } label: {
                        Text("Start")
                            .padding()
                            .font(.headline)
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button {
                        print("reset")
                    } label: {
                        Text("Reset")
                            .padding()
                            .font(.headline)
                            .background(Color.red)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button {
                        print("lap")
                    } label: {
                        Text("Lap")
                            .padding()
                            .font(.headline)
                            .background(Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                    

    
                }
                Spacer()
            }
        
        }
//
//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
