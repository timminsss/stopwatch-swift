//
//  ContentView.swift
//  stopwatch
//
//  Created by Shelley Timmins on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    var runningTime:Bool = false
    
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
                    
                    if !runningTime {
                        Button {
                            print("start")
                            // Start the stop watch - seconds, minutes, hours to start counting
                        } label: {
                            Text("Start")
                                .padding()
                                .font(.headline)
                                .background(Color.green)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    } else {
                        Button {
                            print("stop")
                            // Pause the stopwatch
                        } label: {
                            Text("Stop")
                                .padding()
                                .font(.headline)
                                .background(Color.red)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                    Spacer()
                    if runningTime {
                        Button {
                            print("lap")
                            // Continue stopwatch
                            // save the exact time when pressed
                            // show time with lap number under
                        } label: {
                            Text("Lap")
                                .padding()
                                .font(.headline)
                                .background(Color.orange)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    } else {
                        Button {
                            print("reset")
                            // Stop the stopwatch
                            // Set stopwatch back to 0
                        } label: {
                            Text("Reset")
                                .padding()
                                .font(.headline)
                                .background(Color.red)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
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
