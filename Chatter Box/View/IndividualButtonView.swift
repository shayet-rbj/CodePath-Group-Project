//
//  IndividualButtonView.swift
//  Chatter Box
//
//  Created by Vanessa Johnson on 4/18/24.
//

import SwiftUI

struct IndividualButtonView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    var imageName: String
    var buttonText: String
    var body: some View {
            Button(action: {
                if buttonText == "Logout"{
                    Task{
                        do {
                            try await authViewModel.logOut()
                        } catch {}
                    }
                }
            }){
                HStack{
                    Image(systemName: imageName).resizable().frame(width: 20, height: 20).tint(Color.white)
                    Text("\(buttonText)").tint(Color.white)
                    Spacer()
                }.padding()
            }
        .background(Color(hex: "#343541"))
    }
}

#Preview {
    IndividualButtonView(imageName: "trash", buttonText: "Clear conversations")
}
