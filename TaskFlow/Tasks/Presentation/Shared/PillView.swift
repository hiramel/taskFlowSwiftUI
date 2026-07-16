//
//  PillView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 23/06/26.
//

import SwiftUI

struct PillView: View {
    
    let pillText: String
    var tint: Color = .red
    
    var body: some View {
        Text(pillText)
            .font(.system(.body, design: .rounded))
            .bold()
            .foregroundStyle(tint)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(tint.opacity(0.12))
            .clipShape(Capsule())
    }
}

#Preview {
    PillView(pillText: "High")
}
