//
//  TaskButtonView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 23/06/26.
//

import SwiftUI

struct TaskButtonView: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.body, design: .rounded))
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(red: 0.44, green: 0.24, blue: 0.82))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

#Preview {
    TaskButtonView(title: "Edit Task") { }
        .padding()
}
