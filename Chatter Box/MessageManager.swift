//
//  MessageManager.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import OpenAI
import SwiftUI

@Observable // <-- Add the Observable macro
class MessageManager {
    
    var type: String
    var messages: [Message] = []
    var chatMessages: [Message] = []
    let openAI = OpenAI(apiToken: "OPEN_AI_API_KEY")
    
    private let dataBase = Firestore.firestore()

    init(isMocked: Bool = false, chatType: String) {
        if isMocked {
            messages = Message.mockedMessages
            type = chatType
        } else {
            // TODO: Fetch messages from Firestore database
            type = chatType
            getMessages()
        }
    }

    // TODO: Save message
    func getMessages() {
        // Access the "Messages" collection group in Firestore and listen for any changes
        dataBase.collectionGroup(type).addSnapshotListener { querySnapshot, error in

            // Get the documents for the messages collection (a document represents a message in this case)
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Map Firestore documents to Message objects
            let messages = documents.compactMap { document in
                do {

                    // Decode message document to your Message data model
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            // Update the messages property with the fetched messages (sorting ascending timestamp)
            self.messages = messages.sorted(by: { $0.timestamp < $1.timestamp })
        }
    }


    // TODO: Get messages
    func sendMessage(text: String, username: String) {
        do {

            // Create a message object
            let message = Message(id: UUID().uuidString, text: text, timestamp: Date(), username: username)
            
            // Save message to local chat history for ChatGPT to have most recent history
            self.chatMessages.append(message)

            // Save the message to your Firestore database
            try dataBase.collection(type).document().setData(from: message)

        } catch {
            print("Error sending message to Firestore: \(error)")
        }
    }
    
    // Get reply from ChatGPT after sending a message
    func getBotReply(choice: String) {
        var personalityPrompt = "You must respond to everything as if you are the happiest person in the world." // Default is Nice chatbot
        
        // Change chatbot personality based on chat choice
        if choice == "Nice" {
            personalityPrompt = "You must respond to everything as if you are the happiest person in the world."
        }
        else if choice == "Mean" {
            personalityPrompt = "You must respond to everything as if you are the meanest person in the world."
        }
        else if choice == "Sad" {
            personalityPrompt = "You must respond to everything as if you are the saddest person in the world."
        }
        
        let query = ChatQuery(messages: [.init(role: .user, content: personalityPrompt)!] + self.chatMessages.map({
            .init(role: .user, content: $0.text)!
        }),
            model: .gpt3_5Turbo
        )
        
        self.openAI.chats(query: query) { result in
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                guard let message = choice.message.content?.string else { return }
                DispatchQueue.main.async {
                    self.sendMessage(text: message, username: "gpt3_5turbo")
                    self.chatMessages.append(Message(id: UUID().uuidString, text: message, timestamp: Date(), username: "gpt3_5turbo"))
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
