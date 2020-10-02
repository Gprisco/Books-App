//
//  ProgressCircleBar.swift
//  Books App
//
//  Created by Giovanni Prisco on 30/09/2020.
//

import SwiftUI

struct ProgressCircleBar: View {
    var progress: Double
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: 32, height: 32)
            .overlay(
                Circle().trim(from:0, to: CGFloat(progress))
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 4.5,
                            lineCap: .round,
                            lineJoin:.round
                        )
                    )
                    .foregroundColor(
                        (progress == 1.0 ? .green : progress > 0.3 ? .orange: .red)
                    ).animation(
                        .easeInOut(duration: 0.2)
                    )
            )
    }
}

struct ProgressCircleBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleBar(progress: 1.0)
    }
}
