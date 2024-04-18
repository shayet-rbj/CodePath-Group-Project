//
//  ChatView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct ChatView: View {
    var choice: String
    @State private var textInput: String = ""
    var body: some View {
        VStack{
            Spacer()
            HStack{
                TextField("Type Here", text: $textInput).frame(width: 300, height: 52).fixedSize(horizontal: true, vertical: false).border(Color.gray, width: 1)
                    .overlay(
                        Button(action: {
                            
                        }){
                            Image("textfieldButton")
                                .padding(.trailing, 8)
                        },
                    alignment: .trailing)
                
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(hex: "#343541"))
    }
}

#Preview {
    ChatView(choice: "Mean")
}
