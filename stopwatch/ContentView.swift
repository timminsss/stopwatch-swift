//
//  ContentView.swift
//  stopwatch
//
//  Created by Shelley Timmins on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State var runningTime = true
    @State var timeElapsed: TimeInterval = 0.0
    // on: is the scheduler for when this occurs
    // .main is the main loop scheduler - this updates the ui when changes happen
    // in: is the mode or quality of service level of priority/behaviour
    // .common means event is processed even if for example user is scrolling or similar
    // autoconnect() means you don't need to do anything for the timer to start - do we want this?
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Stopwatch")
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text(formatTimeInterval(timeElapsed) ?? "")
                    // modifer that picks up any changes from a publisher
                    .onReceive(timer) { _ in
                        if runningTime {
                            timeElapsed += 0.1
                        }
                    }
                    .padding()
                    .font(.system(size: 40, weight: .bold))
                Spacer()
                HStack {
                    Spacer()
                    if runningTime {
                        Button {
                            // Pause the timeElapsed
                            print("stop")
                            runningTime = false
                        } label: {
                            Text("Stop")
                                .padding()
                                .font(.headline)
                                .background(Color.red)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    } else {
                        Button {
                            print("start")
                            // Start the timeElapsed
                            runningTime = true
                        } label: {
                            Text("Start")
                                .padding()
                                .font(.headline)
                                .background(Color.green)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                    Spacer()
                    if runningTime {
                        Button {
                            print("lap")
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
                            // Stop the timeElapsed
                            // Set stopwatch back to 0
                            timeElapsed = 0.0
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
    }
    
    // using the _ means you don't have to name the parameter when you call it
    func formatTimeInterval(_ interval: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: interval)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
