//
//  LoginView.swift
//  BocketList
//
//  Created by Isaque da Silva on 22/09/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated == false {
            LockedView(typeOfBiometry: viewModel.typeOfBiometry, authenticate: viewModel.authenticate)
        } else {
            HomeView()
        }
    }
}
