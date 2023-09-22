//
//  EditView.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditViewModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Insert the name of place", text: $viewModel.name)
                    TextField("Insert a description for the place", text: $viewModel.description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        viewModel.save()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: EditViewModel(location: location, onSave: onSave))
    }
}
