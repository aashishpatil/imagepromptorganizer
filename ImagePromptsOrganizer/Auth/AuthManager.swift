//
//  AuthManager.swift
//
//  Created by Aashish Patil on 10/5/25.
//

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import Observation
import OSLog
import Combine

import AuthenticationServices

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif


@Observable
@MainActor
public class AuthManager {
    
    // current state of auth
    private(set) public var state: AuthState = .unintialized
    
    private var authProtocol: NSObjectProtocol?
    
    init() {
        Logger.auth.debug("Initializng AuthManager")
        if let currentUser = Auth.auth().currentUser {
            DispatchQueue.main.async {
                self.state = .signedIn(currentUser)
            }
        }
        
        self.monitorAuthState()
    }
    
    // MARK: FirebaseAuth
    
    func monitorAuthState() {
        Logger.auth.info("Starting monitor for auth state")
        authProtocol = Auth.auth().addStateDidChangeListener { auth, _ in
            Logger.auth.log("auth state did change \(auth) \(auth.currentUser)")
            
            guard let user = auth.currentUser else {
                Logger.auth.log("no current user")
                DispatchQueue.main.async {
                    self.state = .signedOut
                }
                return
            }
            
            DispatchQueue.main.async {
                self.state = .signedIn(user)
                if let guser = GIDSignIn.sharedInstance.currentUser {
                    DispatchQueue.main.async {
                        self.authorizer = guser.fetcherAuthorizer
                    }
                }
                Logger.auth.debug("User signed in successfully")
            }
        }
    }
    
    
    func signOut() throws {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance.signOut()
        self.state = .signedOut
    }
    
    
    private func handleAuth(signInResult: GIDSignInResult?) async throws {
        guard let signInResult = signInResult else {
            //Logger.endeavor.log("No signInResult - unable to complete auth")
            print("No signInResult - unable to complete auth")
            return
        }
        
        guard let idToken = signInResult.user.idToken else {
            //Logger.endeavor.error("Completed auth but no idToken")
            print("Completed auth but no idToken")
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: signInResult.user.accessToken.tokenString)
        
        //Logger.endeavor.info("Completed google auth. Now attempting Firebase auth")
        print("Completed google auth. Now attempting Firebase auth")
        
        let authResult = try await Auth.auth().signIn(with: credential)
        //Logger.endeavor.log("Complete Auth with result \(authResult, privacy: .private)")
        print("authResult \(authResult)")
        self.state = .signedIn(authResult.user)
    }
    
    @MainActor
    public func isSignedIn() -> Bool {
        switch self.state {
        case .signedIn(_): return true
        default : return false
        }
    }
    
    // MARK: Google Auth
    
    // authorizer required to sign
    var authorizer: (any GTMFetcherAuthorizationProtocol)? = nil
    
    @MainActor
    public func signIn(scopes: [String]) async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            //Logger.endeavor.error("No firebase app id specified")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
#if os(iOS)
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        try await handleAuth(signInResult: signInResult)
        
#elseif os(macOS)
        guard let presentingWindow = NSApplication.shared.windows.first else {
            print("There is no presenting window!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingWindow) { signInResult, error in
            self.handleAuth(signInResult: signInResult, error: error)
        }
#endif
    }
    
    
    // MARK: Apple Sign In
    
    public func signInWithApple(_ appleCredentials: ASAuthorizationAppleIDCredential) async throws {
        print("Attempting to sign in with Apple")
        
        do {
            
            guard let token = appleCredentials.identityToken else {
                print("No identityToken available from Apple Credentials")
                return
            }
            
            let creds = OAuthProvider.appleCredential(withIDToken: String(data: token, encoding: .utf8)!, rawNonce: nil, fullName: nil)
            let authData = try await Auth.auth().signIn(with: creds)
            print("Signed in with Apple: \(authData)")
            self.state = .signedIn(authData.user)
        } catch {
            print("Error signing in with Apple: \(error)")
            throw error
        }
    }
    
    
    
}
