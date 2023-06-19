//  Created by Shelley Timmins on 15/06/2023.
import SwiftUI

struct TimerView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State private var showStopwatchView = false
    @State private var runningTime = false
    // Updated from the picker or from buttons
    @State private var pickerMinutes = 0
    @State private var pickerSeconds = 0
    // Need to convert the picker mins and secs to time interval
    @State private var timeRemaining: TimeInterval = 0
    
    // Same as stopwatch - publishes each second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 50)
                
                Text("Timer")
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .font(.system(size: 24, weight: .bold))
                
                Spacer().frame(height: 50)
                
                Text("\(formatTimeInterval(timeRemaining))")
                // modifer that picks up any changes from a publisher
                    .onReceive(timer) { _ in
                        if runningTime && timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            runningTime = false
                        }
                    }
                    .padding()
                    .font(.system(size: 40, weight: .bold))
                
                Spacer()
                
                // Picker to be able to select custom time
                Form {
                    HStack{
                        Picker("Minutes", selection: $pickerMinutes) {
                            ForEach(0..<60) { minute in
                                Text("\(minute) mins")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Picker("Seconds", selection: $pickerSeconds) {
                            ForEach(0..<60) { second in
                                Text("\(second) secs")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    .frame(height: 100)
                }
                
                // Update this later to loop through if possible through grid
                Grid(horizontalSpacing: 24, verticalSpacing: 24) {
                    GridRow {
                        Button {
                            print("1 min")
                            pickerMinutes = 1
                            runningTime = true
                        } label: {
                            Text("1 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("5 min")
                            pickerMinutes = 5
                            runningTime = true
                        } label: {
                            Text("5 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("10 min")
                            pickerMinutes = 10
                            runningTime = true
                        } label: {
                            Text("10 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                    GridRow {
                        Button {
                            print("15 min")
                            pickerMinutes = 15
                            runningTime = true
                        } label: {
                            Text("15 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("20 min")
                            pickerMinutes = 20
                            runningTime = true
                        } label: {
                            Text("20 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("30 min")
                            pickerMinutes = 30
                            runningTime = true
                        } label: {
                            Text("30 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                }
                
                
                HStack {
                    Button {
                        print("start")
                        // Update the timer to the converted time
                        timeRemaining = convertPickerTimesToTime(pickerMinutes, pickerSeconds)
                        runningTime = true
                    } label: {
                        Text("Start")
                            .padding()
                            .font(.headline)
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    //                    Might add this later
                    //                    Button {
                    //                        print("pause")
                    //                        runningTime = false
                    //                    } label: {
                    //                        Text("Pause")
                    //                            .padding()
                    //                            .font(.headline)
                    //                            .background(Color.green)
                    //                            .foregroundColor(.black)
                    //                            .cornerRadius(10)
                    //                    }
                    Button {
                        print("reset")
                        // Stop the timer and reset
                        timeRemaining = 0
                        pickerMinutes = 0
                        pickerSeconds = 0
                        runningTime = false
                    } label: {
                        Text("Reset")
                            .padding()
                            .font(.headline)
                            .background(Color.red)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                }
                Button("Show Stopwatch View") {
                    showStopwatchView.toggle()
                }
                .sheet(isPresented: $showStopwatchView) {
                    StopwatchView()
                }
                .padding()
                .background(Color.teal)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .font(.headline)
                
            }
        }
    }
    
    func convertPickerTimesToTime(_ minutes: Int, _ seconds: Int) -> TimeInterval {
        // TimeInterval is double therefore output needs to be double
        let timeIntervalSeconds = Double((minutes * 60) + seconds)
        timeRemaining = timeIntervalSeconds
        return TimeInterval(timeIntervalSeconds)
    }
    
    // Using the _ means you don't have to name the parameter when you call it
    func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        // Adds leading zeros so the format is consistent
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval)!
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
