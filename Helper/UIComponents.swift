//
//  UIComponents.swift
//  interactive-design
//
//  Created by Phat Nantanat on 16/11/2568 BE.
//

import SwiftUI

// ส่วนหัว
struct LevelHeader: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.largeTitle.bold())
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 40)
    }
}

// กล่องคำแนะนำ
struct TipsBox: View {
    let tips: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("💡")
                Text("ทำอะไรบ้าง")
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(tips, id: \.self) { tip in
                    Text("• \(tip)")
                }
            }
            .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
