//
//  LoginView.swift
//  ImagePromptsOrganizer
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

import SwiftUI

import SwiftUI
import OSLog

import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct LoginView: View {
    
    @Environment(AuthManager.self) var authManager
    
    var body: some View {
        VStack(spacing: 25) {
            
            GoogleSignInButton{
                Task {
                    do {
                        try await authManager.signIn(scopes: [])
                    } catch {
                        Logger.auth.error("Error signing into Google \(error)")
                    }
                }
            }
            .frame(width: 108.0, height: 52.0)
            
            /*
             // Not tested
            SignInWithAppleButton { request in
                print("on request \(request)")
            } onCompletion: { result in
                print("on completion \(result)")
                switch result {
                case .failure(let error):
                    print("Apple Sign In Error: \(error)")
                case .success(let authorization):
                    Task {
                        print("Apple Sign In Success: \(authorization)")
                        try await authManager.signInWithApple(authorization.credential as! ASAuthorizationAppleIDCredential)
                    }
                }
            }
            .frame(width: 108.0, height: 52.0)
            .signInWithAppleButtonStyle(.white)
            */
        }
    }
}
