//
//  Chatter_BoxApp.swift
//  Chatter Box
//
//  Created by Shayet on 4/13/24.
//

import SwiftUI
import FirebaseCore

@main
struct Chatter_BoxApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init() { // <-- Add an init
            FirebaseApp.configure() // <-- Configure Firebase app
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
