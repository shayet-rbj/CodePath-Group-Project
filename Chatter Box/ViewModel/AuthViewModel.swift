//
//  AuthViewModel.swift
//  Chatter Box
//
//  Created by Shayet on 4/18/24.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject{
    // hold the current session of the Firebase authenticated user
    @Published var userSession: FirebaseAuth.User? = nil
    // hold the custom User object with details from Firestore
    @Published var currentUser: User? = nil
    @Published var isUserAuthenticated = false
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            self.isUserAuthenticated = true
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func signUp(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            self.isUserAuthenticated = true
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func logOut() async{
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil
            self.isUserAuthenticated = false
            print("DEBUG: Successfully log out")
        } catch{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            
        }
    }
    
    func deleteAccount() async {
        
    }
    

    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.isUserAuthenticated = false // If there's no current user, set isUserAuthenticated to false
            return
        }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        
        if let currentUser = try? snapshot.data(as: User.self) {
            self.currentUser = currentUser
            self.isUserAuthenticated = true // Set isUserAuthenticated to true if user data is successfully fetched
            print("DEBUG: Current user is \(currentUser)")
        }
    }
}
