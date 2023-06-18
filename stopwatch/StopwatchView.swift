//  Created by Shelley Timmins on 15/06/2023.
import SwiftUI

struct StopwatchView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State private var runningTime = false
    @State private var timeElapsed: TimeInterval = 0.0
    @State private var lapArray: [String] = []
    @State private var showTimerView = false
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
                Spacer().frame(height: 50)
                Text("Stopwatch")
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text(formatTimeInterval(timeElapsed))
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
                            // save the exact time when pressed and add to lap array
                            let lapTime = formatTimeInterval(timeElapsed)
                            lapArray.append(lapTime)
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
                            lapArray = []
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
                .padding(.bottom, 10)
                
                List {
                    // need to add enumerated() to allow access to the index
                    ForEach(Array(lapArray.enumerated()), id: \.1) { index, lap in
                        HStack {
                            Spacer()
                            Text("Lap \(index + 1)")
                            Spacer()
                            Text(lap)
                            Spacer()
                        }
                    }
                }
                
                Button("Show Timer View") {
                    showTimerView.toggle()
                }
                .sheet(isPresented: $showTimerView) {
                    TimerView()
                }
                .padding()
                .background(Color.teal)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .font(.headline)
            }
        }
    }
    
    // using the _ means you don't have to name the parameter when you call it
    func formatTimeInterval(_ interval: TimeInterval) -> String {
        // formatter doesn't suppoer ms so need to calc manually
        // can't use % on decimals so need truncatingRemainder
        let milliseconds = Int((interval.truncatingRemainder(dividingBy: 1)) * 100)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        // adds leading zeros so the format is consistent
        formatter.zeroFormattingBehavior = .pad
        
        // return the time plus manually calc ms
        return formatter.string(from: interval)! + String(format: ":%02d", milliseconds)
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
