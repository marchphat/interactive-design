//
//  Level3.swift
//  interactive-design
//
//  Created by Phat Nantanat on 16/11/2568 BE.
//

import SwiftUI

// Topic:
// DragGesture + .offset

struct Level3: View {
    @State private var scale: CGFloat = 1.0
    
    // 1. เก็บตำแหน่ง
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                LevelHeader(
                    title: "ไปไหนไปกัน",
                    subtitle: "ลองลากรูปทรงไปมา!"
                )
                
                Spacer().frame(height: 60)
                
                Circle()
                    .fill(isDragging ? Color.blue : Color.purple)
                    .frame(width: 140, height: 140)
                    .scaleEffect(scale)
                    .offset(offset)  // 2. ใช้ตำแหน่งที่เก็บไว้
                    .gesture(
                        // 3. เลือกการลาก
                        DragGesture()
                            .onChanged { value in
                                // 4. ขณะลาก → เลื่อนตามนิ้ว
                                offset = value.translation
                                scale = 1.05
                                isDragging = true
                            }
                            .onEnded { _ in
                                // 5. เมื่อปล่อย → กลับที่เดิม
                                withAnimation(.spring()) {
                                    offset = .zero
                                    scale = 1.0
                                    isDragging = false
                                }
                            }
                    )
                
                Text(isDragging ? "🎉 กำลังลาก!" : "👆 ลองลากดูสิ")
                    .font(.headline)
                
                Spacer().frame(height: 250)
                
                TipsBox(tips: [
                    "เพิ่ม @State private var offset: CGSize = .zero",
                    "เพิ่ม .offset(offset)",
                    "ใช้ DragGesture().onChanged/onEnded"
                ])
                
                Spacer()
            }
        }
    }
}
