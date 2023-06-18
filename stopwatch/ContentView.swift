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
                Text("Stopwatch App ")
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .font(.system(size: 24, weight: .bold))
                
                Spacer()
                
                HStack {
                    Button("Stopwatch") {
                        showStopwatchView.toggle()
                    }
                    .sheet(isPresented: $showStopwatchView) {
                        StopwatchView()
                    }
                    .padding()
                    .font(.headline)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    Button("Timer") {
                        showTimerView.toggle()
                    }
                    .sheet(isPresented: $showTimerView) {
                        TimerView()
                    }
                    .padding()
                    .font(.headline)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                }
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
