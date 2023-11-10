//
//  LockedView.swift
//  BocketList
//
//  Created by Isaque da Silva on 10/11/23.
//

import SwiftUI

struct LockedView: View {
    let typeOfBiometry: String
    var authenticate: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "lock.fill")
                .font(.system(size: 48))
                .foregroundColor(.blue)
                .padding(.top, 32)
                .padding(.bottom, 24)
            Text("Bucket List is locked")
                .font(.title.bold())
                .padding(5)
            Text("Use the \(typeOfBiometry) to unlock Bucket List")
                .font(.headline)
            
            Spacer()
            
            Button("Use the \(typeOfBiometry)") {
                authenticate()
            }
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}
