//
//  Level1.swift
//  interactive-design
//
//  Created by Phat Nantanat on 16/11/2568 BE.
//

import SwiftUI

// Topic:
// @State + .onTapGesture

struct Level1: View {
    // 1. จำสถานะ
    @State private var isPressed = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                LevelHeader(
                    title: "มาลองกดกัน",
                    subtitle: "ลองกดรูปทรงเพื่อดู feedback!"
                )
                
                Spacer().frame(height: 60)
                
                Circle()
                    // 2. เช็คเงื่อนไข
                    .fill(isPressed ? Color.blue : Color.red)
                    .frame(width: 140, height: 140)
                    // 3. รับคำสั่งเมื่อกด
                    .onTapGesture {
                        // 4. สลับสถานะ
                        isPressed.toggle()
                    }
                
                Text(isPressed ? "✓ กดแล้ว!" : "ลองกดสิ")
                    .font(.headline)
                
                Spacer().frame(height: 40)
                
                TipsBox(tips: [
                    "เพิ่ม @State private var isPressed = false",
                    "เช็คเงื่อนไข isPressed ? blue : red",
                    "เพิ่ม .onTapGesture { toggle() }"
                ])
                
                Spacer()
            }
        }
    }
}
