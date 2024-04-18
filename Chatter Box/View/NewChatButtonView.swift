//
//  NewChatButtonView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct NewChatButtonView: View {
    @State private var selectedChoice: String?
    @State private var isOptionsVisible: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isOptionsVisible.toggle()
            }) {
                HStack {
                    Image("messageBubble").resizable().frame(width: 20, height: 20)
                    Text("New Chat").foregroundColor(.white)
                    Spacer()
                    Image("arrowStroke").resizable().frame(width: 20, height: 20)
                }
                .padding()
            }
            
            Rectangle().fill(Color.gray).frame(height: 2)
            
            if isOptionsVisible {
                VStack(alignment: .leading) {
                    ForEach(["Nice", "Mean", "Sad"], id: \.self) { option in
                        NavigationLink(
                            destination: ChatView(choice: option),
                            tag: option,
                            selection: $selectedChoice
                        ) {
                            HStack{
                                Image(option)
                                Text(option)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .background(Color(hex: "#343541"))
                        .padding(.horizontal)
                        .cornerRadius(5)
                        .padding(.vertical, 5)
                        
                
                    }
                }
                .background(Color(hex: "#343541"))
                .padding()
            }
        }
        .background(Color(hex: "#343541"))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true) // Hide the navigation bar if needed
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    NewChatButtonView()
}
