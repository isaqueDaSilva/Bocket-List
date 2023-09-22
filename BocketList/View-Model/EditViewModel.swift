//
//  EditViewModel.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import Foundation

extension EditView {
    class EditViewModel: ObservableObject {
        @Published var name: String
        @Published var description: String
        var location: Location
        var onSave: (Location) -> Void
        
        func save() {
            var editedLocation = location
            editedLocation.id = UUID()
            editedLocation.name = name
            editedLocation.description = description
            onSave(editedLocation)
        }
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
    }
}
