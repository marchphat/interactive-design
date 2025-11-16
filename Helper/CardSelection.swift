//
//  CardSelectionView.swift
//  แผงเลือกการ์ดโจทย์ทั้งหมด
//

import SwiftUI

struct CardSelectionView: View {
    @State private var selectedCard: ChallengeCard?
    @State private var showCardDetail = false
    @State private var revealedHints: Set<Int> = []
    @State private var viewedCards: Set<Int> = []
    
    let allCards: [ChallengeCard] = [
        // Level 1 (4 ข้อ)
        ChallengeCard(
            number: 1,
            title: "เปลี่ยนสีเมื่อกด",
            level: "Level 1",
            description: "เมื่อกด → Card เป็นสีแดง\n(แทนที่จะเป็นสีน้ำเงิน)",
            hints: [
                "หา: isPressed ? Color.blue",
                "แก้: เปลี่ยน .blue เป็น .red"
            ]
        ),
        ChallengeCard(
            number: 2,
            title: "เปลี่ยนสีตอนไม่กด",
            level: "Level 1",
            description: "เมื่อไม่กด → Card เป็นสีเขียว\n(แทนที่จะเป็นสีเทา)",
            hints: [
                "หา: : Color.gray",
                "แก้: เปลี่ยน .gray เป็น .green"
            ]
        ),
        ChallengeCard(
            number: 3,
            title: "เปลี่ยนข้อความตามสถานะ",
            level: "Level 1",
            description: "เมื่อกด → แสดง \"เยี่ยม!\"\n(แทนที่จะเป็น \"กดแล้ว\")",
            hints: [
                "หา: isPressed ? \"กดแล้ว\"",
                "แก้: เปลี่ยนเป็น \"เยี่ยม!\""
            ]
        ),
        ChallengeCard(
            number: 4,
            title: "สลับสีทั้งคู่",
            level: "Level 1",
            description: "กด → สีม่วง\nไม่กด → สีส้ม",
            hints: [
                "หา: isPressed ? Color.blue : Color.gray",
                "แก้: เปลี่ยนเป็น .purple : .orange"
            ]
        ),
        
        // Level 2 (4 ข้อ)
        ChallengeCard(
            number: 5,
            title: "โตมากขึ้นเมื่อกด",
            level: "Level 2",
            description: "เมื่อกด → Card โตเป็น 1.5 เท่า\n(แทนที่จะเป็น 1.3)",
            hints: [
                "หา: scale = isPressed ? 1.3 : 1.0",
                "แก้: เปลี่ยน 1.3 เป็น 1.5"
            ]
        ),
        ChallengeCard(
            number: 6,
            title: "Animation เร็วขึ้น",
            level: "Level 2",
            description: "ทำให้ animation เร็วขึ้น\n(ตอนกด Card)",
            hints: [
                "หา: withAnimation(.spring())",
                "เพิ่ม: (response: 0.3)"
            ]
        ),
        ChallengeCard(
            number: 7,
            title: "Animation ช้าลง",
            level: "Level 2",
            description: "ทำให้ animation ช้าลง\n(ตอนลาก Card)",
            hints: [
                "หา: .spring(response: 0.5)",
                "แก้: เปลี่ยน 0.5 เป็น 1.0"
            ]
        ),
        ChallengeCard(
            number: 8,
            title: "โตเล็กลงเมื่อลาก",
            level: "Level 2",
            description: "เมื่อลาก → Card โตแค่ 1.05 เท่า\n(แทนที่จะเป็น 1.1)",
            hints: [
                "หา: scale = 1.1 (ใน onChanged)",
                "แก้: เปลี่ยน 1.1 เป็น 1.05"
            ]
        ),
        
        // Level 3 (2 ข้อ)
        ChallengeCard(
            number: 9,
            title: "ปิด Drag Gesture",
            level: "Level 3",
            description: "ทำให้ลาก Card ไม่ได้",
            hints: [
                "หา: .gesture(DragGesture()...)",
                "ใส่ // หน้าบรรทัด .gesture"
            ]
        ),
        ChallengeCard(
            number: 10,
            title: "ไม่ให้ Card กลับที่เดิม",
            level: "Level 3",
            description: "ลาก → Card ไม่กลับที่เดิม\n(อยู่ที่ที่ปล่อย)",
            hints: [
                "หา: offset = .zero (ใน onEnded)",
                "ใส่ // หน้าบรรทัดนั้น"
            ]
        ),
        
        // ผสม (2 ข้อ)
        ChallengeCard(
            number: 11,
            title: "เพิ่ม Long Press",
            level: "ผสม",
            description: "กดค้าง → Card โตมาก",
            hints: [
                "เพิ่มหลัง .onTapGesture { }",
                "ใช้: .onLongPressGesture { }"
            ]
        ),
        ChallengeCard(
            number: 12,
            title: "Ultimate Challenge",
            level: "ทั้งหมด",
            description: "แก้ทั้งหมด 3 ข้อ:\n1. กด → สีชมพู (Level 1)\n2. กด → โต 1.5 เท่า (Level 2)\n3. ลาก → animation เร็ว 0.3 (Level 2)",
            hints: [
                "1. แก้ Color.blue → .pink",
                "2. แก้ 1.3 → 1.5",
                "3. แก้ response: 0.5 → 0.3"
            ]
        ),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header 
                VStack(spacing: 10) {
                    Text("🎴 เลือกโจทย์")
                        .font(.largeTitle.bold())
                    
                    Text("เลือกการ์ดเพื่อดูโจทย์")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Sections
                cardSection(
                    title: "Level 1: มาลองกดกัน",
                    cards: allCards.filter { $0.level == "Level 1" },
                    color: .blue
                )
                
                cardSection(
                    title: "Level 2: ขยับกันซักนิด",
                    cards: allCards.filter { $0.level == "Level 2" },
                    color: .green
                )
                
                cardSection(
                    title: "Level 3: ไปไหนไปกัน",
                    cards: allCards.filter { $0.level == "Level 3" },
                    color: .purple
                )
                
                cardSection(
                    title: "ผสม: Challenge พิเศษ",
                    cards: allCards.filter { $0.level == "ผสม" || $0.level == "ทั้งหมด" },
                    color: .orange
                )
                
                Spacer().frame(height: 30)
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [.gray.opacity(0.1), .gray.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .sheet(item: $selectedCard) { card in
            CardDetailFullScreen(card: card, revealedHints: $revealedHints)
                .onDisappear {
                    revealedHints.removeAll()
                    viewedCards.insert(card.number)
                }
        }
    }
    
    // Section แต่ละ Level
    private func cardSection(title: String, cards: [ChallengeCard], color: Color) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(color)
                .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(cards) { card in
                    CardButton(
                        card: card,
                        color: color,
                        isViewed: viewedCards.contains(card.number)
                    ) {
                        selectedCard = card
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// ปุ่มการ์ดแต่ละข้อ
struct CardButton: View {
    let card: ChallengeCard
    let color: Color
    let isViewed: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                VStack(spacing: 15) {
                    Text("\(card.number)")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(isViewed ? color.opacity(0.5) : color)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isViewed ? color.opacity(0.05) : color.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    isViewed ? color.opacity(0.2) : color.opacity(0.3),
                                    lineWidth: 2
                                )
                        )
                )
                .shadow(color: color.opacity(0.2), radius: 5, y: 3)
                
                if isViewed {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                                .background(Circle().fill(Color.white).frame(width: 24, height: 24))
                        }
                        Spacer()
                    }
                    .padding(12)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
