//
//  LoginView.swift
//  BocketList
//
//  Created by Isaque da Silva on 22/09/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var manager = AuthenticationManager()
    var body: some View {
        if manager.isAuthenticated == false {
            VStack {
                Image(systemName: "lock.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.blue)
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                Text("Bucket List is locked")
                    .font(.title.bold())
                    .padding(5)
                Text("Use the \(manager.typeOfBiometry) to unlock Bucket List")
                    .font(.headline)
                
                Spacer()
                
                Button("Use the \(manager.typeOfBiometry)") {
                    manager.authenticate()
                }
                .font(.headline.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
        } else {
            HomeView()
        }
    }
}
