//
//  Level2.swift
//  interactive-design
//
//  Created by Phat Nantanat on 16/11/2568 BE.
//

import SwiftUI

// Topic:
// withAnimation + .scaleEffect

struct Level2: View {
    @State private var isPressed = false
    
    // 1. เก็บขนาด
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                LevelHeader(
                    title: "ขยับกันซักนิด",
                    subtitle: "ลองกดรูปทรงเพื่อดู animation!"
                )
                
                Spacer().frame(height: 60)
                
                Circle()
                    .fill(isPressed ? Color.blue : Color.red)
                    .frame(width: 140, height: 140)
                    // 2. ใช้ขนาดที่เก็บไว้
                    .scaleEffect(scale)
                    .onTapGesture {
                        // 3. ห่อด้วย withAnimation
                        withAnimation(.spring()) {
                            isPressed.toggle()
                            scale = isPressed ? 1.2 : 1.0
                        }
                    }
                
                Text(isPressed ? "🎉 เคลื่อนไหวแล้ว!" : "ลองกดสิ")
                    .font(.headline)
                
                Spacer().frame(height: 40)
                
                TipsBox(tips: [
                    "เพิ่ม @State private var scale: CGFloat = 1.0",
                    "เพิ่ม .scaleEffect(scale)",
                    "ห่อด้วย withAnimation(.spring()) { }"
                ])
                
                Spacer()
            }
        }
    }
}
