//
//  SignUpView.swift
//  Chatter Box
//
//  Created by Alex Owens on 4/18/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Image("ChatGPT-logo")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(maxWidth: 60, maxHeight: 60)
            Text("Create your account")
                .font(.largeTitle)
                .foregroundStyle(.white)

            // Email + password fields
            VStack {
                TextField("",
                                  text: $email,
                                  prompt: Text("Email")
                                            .foregroundColor(Color(hex: "#92979f"))
                        )
                .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(hex: "#42434d"), lineWidth: 1)
                            .frame(height: 35)
                    )
                    .foregroundStyle(.white)
                    .tint(.white)
                    .background(Color(hex: "#42434d"))
                    .cornerRadius(8)
                
                SecureField("",
                                  text: $password,
                                  prompt: Text("Password")
                                            .foregroundColor(Color(hex: "#92979f"))
                        )
                .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(hex: "#42434d"), lineWidth: 1)
                            .frame(height: 35)
                    )
                    .foregroundStyle(.white)
                    .tint(.white)
                    .background(Color(hex: "#42434d"))
                    .cornerRadius(8)
            }
            .textInputAutocapitalization(.never) // <-- No auto capitalization (can be annoying for emails and passwords)
            .padding(20)
            
            Button {
                print("Create and log in user: \(email), \(password)")
                // TODO: Log in user
                
                } label: {
                    Text("Create account")
                        .padding(.horizontal, 103)

                        .padding(.vertical, 4)

                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hex: "#11a37f"))
                .padding(.bottom)
            
            HStack {
                Text("Already have an account?")
                    .foregroundStyle(.white)
                
                // TODO: Navigate to log in page
                Button("Log in") {
                    
                }
                .foregroundColor(Color(hex: "#11a37f"))
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(hex: "#343541"))
    }

}

#Preview {
    SignUpView()
}
