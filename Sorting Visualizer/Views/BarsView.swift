//
//  BarsView.swift
//  Sorting Visualizer
//
//  Created by Jayanth Ambaldhage on 25/07/24.
//

import SwiftUI

struct BarsView: View {
    var numbers: [Int]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            ForEach(Array(numbers.enumerated()), id: \.offset) { index, number in
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 10, height: CGFloat(number) * 10)
            }
        }
        .animation(.default, value: numbers)
    }
}

struct BarsView_Previews: PreviewProvider {
    static var previews: some View {
        BarsView(numbers: Array(1...30).shuffled())
    }
}
