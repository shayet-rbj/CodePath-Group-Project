//
//  DashboardView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct DashboardView: View {
    let buttonNames: [String] = ["Clear conversations", "Upgrade to Plus", "Light mode", "Updates & FAQ", "Logout"]
    let buttonImages: [String] = ["trash", "person", "sun.max", "arrow.up.forward.square", "rectangle.portrait.and.arrow.right"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "#343541").edgesIgnoringSafeArea(.all) // Set background color
                VStack(spacing: 0) {
                    NewChatButtonView()
                    Spacer()
                    ForEach(0..<buttonNames.count, id: \.self) { index in
                        IndividualButtonView(imageName: buttonImages[index], buttonText: buttonNames[index])
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use StackNavigationViewStyle to avoid double navigation bars
    }
}



#Preview {
    DashboardView()
}
