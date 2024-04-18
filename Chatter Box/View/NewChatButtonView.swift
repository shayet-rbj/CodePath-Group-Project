//
//  NewChatButtonView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct NewChatButtonView: View {
    @State private var selectedChoice: String = ""
    
    var body: some View {
//        NavigationView {
            VStack {
                Menu {
                    Text("Select Personality Type")
                    ForEach(["Nice", "Mean", "Sad"], id: \.self) { option in
                        NavigationLink(destination: ChatView(choice: option)) {
                            IndividualButtonView(imageName: "face.smiling", buttonText: option)
                        }
                    }
                } label: {
                    HStack {
                        Image("messageBubble").resizable().frame(width: 20, height: 20)
                        Text("New Chat").foregroundColor(.white)
                        Spacer()
                        Image("arrowStroke").resizable().frame(width: 20, height: 20)
                    }
                    .padding()
                }
                
                Rectangle().fill(Color.gray).frame(height: 2)
            }
            .background(Color(hex: "#343541"))
            .navigationBarTitle("")
            .navigationBarHidden(true) // Hide the navigation bar if needed
//        }
    }
}


#Preview {
    NewChatButtonView()
}
