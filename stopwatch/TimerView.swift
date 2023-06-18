//  Created by Shelley Timmins on 15/06/2023.
import SwiftUI

struct TimerView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State private var showStopwatchView = false
    @State private var runningTime = false
    
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
                    .frame(maxWidth: .infinity, alignment: .top)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
