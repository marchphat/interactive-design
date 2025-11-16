//
//  ChallengeGame.swift
//  Challenge Game - หยิบการ์ดแล้วแก้ให้ตรงโจทย์!
//

import SwiftUI

struct ChallengeGame: View {
    // Level 1: @State
    @State private var isPressed = false
    
    // Level 2: ตัวแปรสำหรับ animation
    @State private var scale: CGFloat = 1.0
    
    // Level 3: ตัวแปรสำหรับ gesture
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack(spacing: 40) {
                headerView
                
                Spacer()
                
                cardView
                
                Spacer()
                
                statusView
                
                Spacer().frame(height: 20)
            }
        }
    }
    
    // ⭐ Card - แก้ส่วนนี้ตามโจทย์!
    private var cardView: some View {
        VStack(spacing: 15) {
            Image(systemName: "star.fill")
                .font(.system(size: 50))
                .foregroundColor(.yellow)
            
            Text("MY CARD")
                .font(.title.bold())
                .foregroundColor(.white)
            
            Text(isPressed ? "กดแล้ว" : "ลองกด")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 150, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(isPressed ? Color.blue : Color.gray)
        )
        .scaleEffect(scale)
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring(response: 0.5)) {
                        offset = value.translation
                        scale = 1.1
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.5)) {
                        offset = .zero
                        scale = 1.0
                    }
                }
        )
        .onTapGesture {
            withAnimation(.spring()) {
                isPressed.toggle()
                scale = isPressed ? 1.3 : 1.0
            }
        }
    }
}


#Preview {
    ChallengeGame()
}


// MARK: - ไม่ต้องแก้ส่วนนี้
private extension ChallengeGame {
      var backgroundView: some View {
           LinearGradient(
               colors: [Color.white, Color.gray.opacity(0.3)],
               startPoint: .topLeading,
               endPoint: .bottomTrailing
           )
           .ignoresSafeArea()
       }
       
      var headerView: some View {
           VStack(spacing: 10) {
               Text("Team Challenge")
                   .font(.largeTitle.bold())
               
               Text("แก้ code ให้ตรงโจทย์!")
                   .font(.subheadline)
                   .foregroundColor(.secondary)
           }
           .padding(.top, 30)
       }
       
       var statusView: some View {
           VStack(alignment: .leading, spacing: 8) {
               Text("📊 สถานะ:")
                   .font(.headline)
               
               HStack {
                   VStack(alignment: .leading, spacing: 3) {
                       Text("Level 1: isPressed = \(isPressed ? "true" : "false")")
                       Text("Level 2: scale = \(String(format: "%.1f", scale))")
                       Text("Level 3: offset = (\(Int(offset.width)), \(Int(offset.height)))")
                   }
                   .font(.caption)
               }
           }
           .padding()
           .background(Color.gray.opacity(0.1))
           .cornerRadius(15)
           .padding(.horizontal)
       }
}
