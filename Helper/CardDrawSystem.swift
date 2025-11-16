//
//  CardDrawSystem.swift
//  ระบบสุ่มการ์ดแบบเต็มจอ (ไม่ต้องพึ่ง GameSystem)
//

import SwiftUI

// โมเดลการ์ด
struct ChallengeCard: Identifiable {
    let id = UUID()
    let number: Int
    let title: String
    let level: String
    let description: String
    let hints: [String]  // เปลี่ยนเป็น array
}

// หน้าจอโจทย์เต็มจอ
struct CardDetailFullScreen: View {
    let card: ChallengeCard
    @Binding var revealedHints: Set<Int>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // พื้นหลัง
            LinearGradient(
                colors: [levelColor.opacity(0.6), levelColor.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 40) {
                        // Level
                        Text(card.level)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.black.opacity(0.3))  // ⭐ เพิ่มพื้นหลังดำ
                            .cornerRadius(15)
                        
                        // ชื่อหัวข้อ
                        Text(card.title)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .shadow(color: .black.opacity(0.5), radius: 5, y: 2)  // ⭐ เพิ่มเงา
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                            .padding(.horizontal)
                        
                        // ⭐ โจทย์ - แก้ให้อ่านง่ายขึ้น
                        VStack(alignment: .leading, spacing: 15) {
                            Text("🎯 โจทย์:")
                                .font(.title.bold())
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.5), radius: 3, y: 1)
                            
                            Text(card.description)
                                .font(.system(size: 26, weight: .semibold))  // ⭐ เพิ่มน้ำหนัก
                                .foregroundColor(.white)
                                .lineSpacing(10)
                                .shadow(color: .black.opacity(0.5), radius: 3, y: 1)  // ⭐ เพิ่มเงา
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(0.4))  // ⭐ เปลี่ยนเป็นดำโปร่งแสง
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                )
                        )
                        .padding(.horizontal)
                        
                        Spacer().frame(height: 100)
                    }
                    .padding(.vertical, 30)
                }
                
                // Hints ด้านล่าง
                hintSection
            }
        }
    }
    
    // ส่วน Hints
    private var hintSection: some View {
        VStack(spacing: 15) {
            Text("💡 Hints:")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            HStack(spacing: 15) {
                ForEach(card.hints.indices, id: \.self) { index in
                    HintCard(
                        number: index + 1,
                        hint: card.hints[index],
                        isRevealed: revealedHints.contains(index)
                    ) {
                        let _ = withAnimation(.spring()) {
                            revealedHints.insert(index)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 25)
    }
    
    var levelColor: Color {
        if card.level.contains("Level 1") { return .blue }
        if card.level.contains("Level 2") { return .green }
        if card.level.contains("Level 3") { return .purple }
        return .orange
    }
}

// การ์ด Hint ที่พลิกได้
struct HintCard: View {
    let number: Int
    let hint: String
    let isRevealed: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack {
                if isRevealed {
                    ScrollView {
                        Text(hint)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    VStack(spacing: 10) {
                        Image(systemName: "questionmark")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        Text("Hint \(number)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .frame(width: 160, height: 180)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isRevealed ? Color.white : Color.blue.opacity(0.8))
                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
            )
            .rotation3DEffect(
                .degrees(isRevealed ? 0 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
        }
        .buttonStyle(.plain)
        .disabled(isRevealed)
    }
}
