//
//  NewChatButtonView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct NewChatButtonView: View {
    var body: some View {
        VStack{
            Button(action: {
                
            }){
                HStack{
                    Image("messageBubble").resizable().frame(width: 20, height: 20)
                    Text("New Chat").tint(Color.white)
                    Spacer()
                    Image("arrowStroke").resizable().frame(width: 20, height: 20)
                }.padding()
            }
            Rectangle().fill(Color.gray).frame(width: 360,height: 2)
        }
        .background(Color(hex: "#343541"))
    }
}

#Preview {
    NewChatButtonView()
}
