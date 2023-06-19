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
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 48)
                HStack{
                    Image(systemName: "stopwatch")
                    Text("Stopwatch")
                }
                .padding()
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .top)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.white)
                
                Spacer()
                
                Text(formatTimeInterval(timeElapsed))
                // modifer that picks up any changes from a publisher
                    .onReceive(timer) { _ in
                        if runningTime {
                            timeElapsed += 0.1
                        }
                    }
                    .padding()
                    .font(.system(size: 64))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                HStack {
                    Spacer()
                    if runningTime {
                        Button {
                            runningTime = false
                        } label: {
                            Text("Pause")
                                .padding()
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                    } else {
                        Button {
                            runningTime = true
                        } label: {
                            Text("Start")
                                .padding()
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                    }
                    Spacer().frame(maxWidth: 48)
                    if runningTime {
                        Button {
                            let lapTime = formatTimeInterval(timeElapsed)
                            lapArray.append(lapTime)
                        } label: {
                            Text("Lap")
                                .padding()
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .background(Color.teal)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                    } else {
                        Button {
                            timeElapsed = 0.0
                            lapArray = []
                        } label: {
                            Text("Reset")
                                .padding()
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(48)
                
                // Using ScrollView and not List as the black background doesn't work when the list begins empty before loop
                ScrollView {
                    // Need to add enumerated() to allow access to the index
                    ForEach(Array(lapArray.enumerated()), id: \.1) { index, lap in
                        HStack {
                            Spacer()
                            Text("Lap \(index + 1)")
                            Spacer()
                            Text(lap)
                            Spacer()
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                }
                .background(Color.black)
                .foregroundColor(Color.white)
                
                Button {
                    showTimerView.toggle()
                } label: {
                    Text("Go to")
                    Image(systemName: "timer")
                }
                .sheet(isPresented: $showTimerView) {
                    TimerView()
                }
                .padding()
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .font(.headline)
            }
        }
    }
    
    // Using the _ means you don't have to name the parameter when you call it
    func formatTimeInterval(_ interval: TimeInterval) -> String {
        // Formatter doesn't support ms so need to calc manually
        // Can't use % on decimals so need truncatingRemainder
        let milliseconds = Int((interval.truncatingRemainder(dividingBy: 1)) * 100)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        // Adds leading zeros so the format is consistent
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval)! + String(format: ".%02d", milliseconds)
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
        
    }
}
