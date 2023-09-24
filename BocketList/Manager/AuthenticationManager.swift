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
    
    let context = LAContext()
    
    var typeOfBiometry: String {
        var type = ""
        if context.biometryType == .faceID {
            type = "Face ID"
        } else if context.biometryType == .touchID {
            type = "Touch ID"
        }
        return type
    }
    
    func authenticate() {
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                }
                
                if (error != nil) {
                    print("Error: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    }
    
    init() {
        self.authenticate()
    }
}
