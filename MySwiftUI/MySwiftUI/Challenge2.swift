//
//  Challenge2.swift
//  MySwiftUI
//
//  Created by Color Lines on 6/24/23.
//

import SwiftUI

struct Challenge2: View {
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
                .renderingMode(.original)
                .resizable()
                .frame(width: 50, height: 50)
            Text("Sunny")
                .font(.title)
                .fontWeight(.semibold)
            Text("H: 61º L: 44º")
                .opacity(0.7)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.white, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .clipShape(RoundedRectangle(cornerRadius: 12.0))
        )
    }
}

#Preview {
    Challenge2()
}
