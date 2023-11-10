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
                    TextField("Insert the name of place...", text: $viewModel.name)
                    TextField("Insert a description for the place...", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) {
                            Text($0.title)
                                .font(.headline)
                            + Text(": ") +
                            Text($0.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later...")
                    }
                }
            }
            .navigationTitle("Place Details")
            .navigationBarTitleDisplayMode(.inline)
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
    
    init(manager: LocationManager, location: Location, onSave: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: EditViewModel(manager: manager, location: location, onSave: onSave))
    }
}
