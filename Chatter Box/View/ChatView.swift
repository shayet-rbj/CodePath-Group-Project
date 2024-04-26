//
//  ChatView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct ChatView: View {
    var choice: String
//    @State private var textInput: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var messageManager: MessageManager
        
    init(choice: String, isMocked: Bool = false) {
        self.choice = choice
        messageManager = MessageManager(isMocked: isMocked, chatType: choice)
    }

    var body: some View {
        VStack{
            ScrollView { // <-- Add ScrollView
                VStack { // <-- Add VStack
                    ForEach(messageManager.messages) { message in
                        if message.username == "gpt3_5turbo" {
                            MessageRow(text: message.text, isOutgoing: false)
                            // Set isOutgoing to false if chatgpt's response
                        }
                        else {
                            MessageRow(text: message.text, isOutgoing: true /*authViewModel.currentUser?.email == message.username*/
                                       // set isOutgoing = true for preview to work.
                            )
                        }
                    }
                }
            }
            .defaultScrollAnchor(.bottom)
            .safeAreaInset(edge: .bottom) {
                SendMessageView { messageText in // <-- Add SendMessageView
                    // TODO: Save message to Firestore
                    messageManager.sendMessage(text: messageText, username: authViewModel.currentUser?.email ?? "")
                    messageManager.getBotReply(choice: choice)
                }
            }
            Spacer()
        }
        .navigationBarTitle("\(choice)", displayMode: .inline)
        .navigationBarItems(leading: Image(systemName: "person").foregroundColor(.white))
        .navigationBarItems(trailing: Image("barPicture").foregroundColor(.white))
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(hex: "#343541"))
    }
}

struct SendMessageView: View {
    var onSend: (String) -> Void

    @State private var textInput: String = "" 

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            TextField("Message", text: $textInput, axis: .vertical) // <-- Message text field
                .frame(width: 250, height: 52)
                .padding(.leading)
                .foregroundColor(.white)
//                .padding(.trailing, 4)
//                .padding(.vertical, 8)
                .background(Color(hex: "#343541"))
            
            // Send message button
            Button {
                onSend(textInput) // <-- Call onSend closure passing in the message text when send button is tapped
                textInput = "" // <-- Clear the message text after being sent
            } label: {
                Image("textfieldButton")
                    .padding(.vertical, 3)
                    .padding(5)
            }
            .disabled(textInput.isEmpty) // <-- Disable button if text is empty
        }
        .background(Color(hex: "#343541"))
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.gray))
//        .padding(.horizontal)
//        .padding(.vertical, 8)
        .background(.thickMaterial)
    }
}

struct MessageRow: View {
    let text: String // <-- The message text
    let isOutgoing: Bool // <-- true if sent by the current user

    var body: some View {
        HStack {
            if isOutgoing {
                Spacer()
            }
            messageBubble
            if !isOutgoing {
                Spacer()
            }
        }
    }

    private var messageBubble: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(isOutgoing ? .white : .primary)
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(isOutgoing ? Color(hex: "#10A37F") : Color(.systemGray5))
            )
            .padding(isOutgoing ? .trailing : .leading, 12)
            .containerRelativeFrame(.horizontal, count: 7, span: 5, spacing: 0, alignment: isOutgoing ? .trailing : .leading) 
    }
}

#Preview {
    ChatView(choice: "Mean", isMocked: true)
}
