//  Created by Shelley Timmins on 15/06/2023.
import SwiftUI

struct TimerView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State private var showStopwatchView = false
    @State private var runningTime = false
    @State private var pickerMinutes = 0
    @State private var pickerSeconds = 0
    
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
                
                Text("00:00")
                    .padding()
                    .font(.system(size: 40, weight: .bold))
                
                Spacer()
                
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
                
                // update this later to loop through if possible through grid
                Grid(horizontalSpacing: 24, verticalSpacing: 24) {
                    GridRow {
                        Button {
                            print("1 min")
                        } label: {
                            Text("1 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("5 min")
                        } label: {
                            Text("5 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("10 min")
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
                        } label: {
                            Text("15 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("20 min")
                        } label: {
                            Text("20 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Button {
                            print("30 min")
                        } label: {
                            Text("30 min")
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
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
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
