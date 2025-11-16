//
//  Level0.swift
//  interactive-design
//
//  Created by Phat Nantanat on 16/11/2568 BE.
//

import SwiftUI

// Topic:
// Static UI

struct Level0: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                LevelHeader(
                    title: "มันนิ่งซะเหลือเกิน",
                    subtitle: "ไม่มีอะไรเกิดขึ้นเมื่อกด"
                )
                
                Spacer().frame(height: 40)
                
                VStack(spacing: 30) {
                    Circle()
                        .fill(.red)
                        .frame(width: 120, height: 120)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.green)
                        .frame(width: 120, height: 120)
                    
                    Circle()
                        .fill(.purple)
                        .frame(width: 140, height: 140)
                }
                
                Spacer().frame(height: 40)
                
                TipsBox(tips: [
                    "ไม่ทำอะไรเลย"
                ])
                
                Spacer()
            }
        }
    }
}
