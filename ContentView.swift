//
//  ContentView.swift
//  interactive-design
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                // ส่วนเรียน
                Section("📚 อัพเลเวล") {
                    NavigationLink("Level 0: มันนิ่งซะเหลือเกิน") {
                        Level0()
                    }
                    
                    NavigationLink("Level 1: มาลองกดกัน") {
                        Level1()
                    }
                    
                    NavigationLink("Level 2: ขยับกันซักนิด") {
                        Level2()
                    }
                    
                    NavigationLink("Level 3: ไปไหนไปกัน") {
                        Level3()
                    }
                }
                
                // ระบบเกม
                Section("🎮 Challenge") {
                    NavigationLink("🎯 Game") {
                        ChallengeGame()
                    }
                    
                    NavigationLink("Draw Card") {
                        CardSelectionView()
                    }
                }
                
                // ส่วนอ้างอิง
                Section("📄 เอกสารอ้างอิง") {
                    NavigationLink("ชีทสรุป") {
                        // CheatSheetView()
                    }
                }
            }
            .navigationTitle("Interactive Design")
        }
    }
}
