//  Created by Shelley Timmins on 15/06/2023.
import SwiftUI

struct ContentView: View {
    // @State allows us to update the property and UI is updated whenever the state changes
    @State private var showTimerView = false
    @State private var showStopwatchView = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10) {
                Text("Stopwatch & Timer")
                    .padding()
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                HStack {
                    Button {
                        showStopwatchView.toggle()
                    } label: {
                        VStack{
                            Image(systemName: "stopwatch")
                            Text("Stopwatch")
                        }
                    }
                    .sheet(isPresented: $showStopwatchView) {
                        StopwatchView()
                    }
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    Spacer().frame(maxWidth: 48)
                    
                    Button {
                        showTimerView.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "timer")
                            Text("Timer")
                        }
                    }
                    .sheet(isPresented: $showTimerView) {
                        TimerView()
                    }
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                }
                .padding(48)
                
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
