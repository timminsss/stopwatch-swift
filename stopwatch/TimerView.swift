//  Created by Shelley Timmins on 15/06/2023.
import SwiftUI

struct TimerView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State private var showStopwatchView = false
    @State private var runningTime = false
    // Need this to monitor Start button from start or from pause
    @State private var timerStarted = false
    // Updated from the picker or from buttons
    @State private var pickerMinutes = 0
    @State private var pickerSeconds = 0
    // Need to convert the picker mins and secs to time interval
    @State private var timeRemaining: TimeInterval = 0
    @State private var timesUpAlert = false
    
    // Same as stopwatch - publishes each second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Set up array for buttons so can loop through
    let buttonData: [(label: String, minutes: Int)] = [
        ("1 min", 1),
        ("5 min", 5),
        ("10 min", 10)
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 48)
                HStack{
                    Image(systemName: "timer")
                    Text("Timer")
                }
                .padding()
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .top)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.white)
                
                Spacer()
                
                Text("\(formatTimeInterval(timeRemaining))")
                // modifer that picks up any changes from a publisher
                    .onReceive(timer) { _ in
                        if runningTime && timeRemaining > 0 {
                            timeRemaining -= 1
                        } else if runningTime && timeRemaining == 0 {
                            runningTime = false
                            timerStarted = false
                            timesUpAlert = true
                        }
                    }
                    .padding()
                    .font(.system(size: 64))
                    .foregroundColor(Color.white)
                
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
                .scrollContentBackground(.hidden)
                .disabled(timerStarted)
                
                Grid(horizontalSpacing: 24, verticalSpacing: 24) {
                    GridRow {
                        ForEach(buttonData, id: \.label) { button in
                            Button {
                                pickerMinutes = button.minutes
                            } label: {
                                Text(button.label)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Color.black)
                                    .font(.headline)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            // Want to disable buttons when timer started until reset
                            .disabled(timerStarted)
                        }
                    }
                }
                
                HStack {
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
                            // Update the timer to the converted time
                            if !timerStarted {
                                timeRemaining = convertPickerTimesToTime(pickerMinutes, pickerSeconds)
                            }
                            runningTime = true
                            timerStarted = true
                        } label: {
                            Text("Start")
                                .padding()
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        .disabled(pickerMinutes==0 && pickerSeconds==0)
                    }
                    Spacer().frame(maxWidth: 48)
                    Button {
                        // Stop the timer and reset
                        timeRemaining = 0
                        pickerMinutes = 0
                        pickerSeconds = 0
                        runningTime = false
                        timerStarted = false
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
                .padding(48)
                Button {
                    showStopwatchView.toggle()
                } label: {
                    Text("Go to")
                    Image(systemName: "stopwatch")
                }
                .sheet(isPresented: $showStopwatchView) {
                    StopwatchView()
                }
                .padding()
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .font(.headline)
                
            }
        }
        .alert(isPresented: $timesUpAlert) {
            Alert(
                title: Text("Timer"),
                message: Text("The timer has ended"),
                dismissButton: .default(Text("OK"),
                                        action: {
                                            timesUpAlert = false
                                        }
                                       )
            )
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
