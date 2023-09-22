//
//  AuthenticationManager.swift
//  BocketList
//
//  Created by Isaque da Silva on 19/09/23.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    self.isAuthenticated = true
                } else {
                    self.isAuthenticated = false
                }
            }
        }
    }
}
