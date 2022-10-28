//
//  ProgressBar.swift
//  dietPlanner
//
//  Created by Aqsa's on 27/09/2022.
//

import SwiftUI

struct ProgressBar: View {
    
    @State var currentProgress: CGFloat = 0.5
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("progressBar"))
                    .frame(width: 300*currentProgress, height: 10)
                
            }
//            Button(action: {self.startLoading()}) {
//                Text("Start timer")
//            }
        }
    }
    
//    func startLoading() {
//        _ = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { timer in
//            withAnimation() {
//                self.currentProgress += 0.01
//                if self.currentProgress >= 1.0 {
//                    timer.invalidate()
//                }
//            }
//        }
//    }
}
struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
