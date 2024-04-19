//
//  ContentView.swift
//  Chatter Box
//
//  Created by Shayet on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        if authViewModel.isUserAuthenticated {
            DashboardView()
        } else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
