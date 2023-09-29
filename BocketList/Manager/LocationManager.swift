//
//  LocationManager.swift
//  BocketList
//
//  Created by Isaque da Silva on 28/09/23.
//

import Foundation

actor LocationManager {
    static let shared = LocationManager()
    
    var locations = [Location]()
    let savePath = FileManager.documentyDirectory.appendingPathComponent("SavedPlace")
    //var onSave: (Location) -> Void
    
    func addNewLocation(latitude: Double, longitude: Double) {
        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: latitude, longitude: longitude)
        self.locations.append(newLocation)
        self.save()
    }
    
    func updateLocation(selectedPlace: Location?, _ location: Location) {
        guard let selectedPlace = selectedPlace else { return }
        
        if let index = self.locations.firstIndex(of: selectedPlace) {
            self.locations[index] = location
            self.save()
        }
    }
    
    func editedCurrentLocation(location: Location, name: String, description: String, onSave: @escaping (Location) -> Void) {
        var editedLocation = location
        editedLocation.id = UUID()
        editedLocation.name = name
        editedLocation.description = description
        onSave(editedLocation)
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Falied to save data in FileManager. Error: \(error)")
        }
    }
    
    func decodeLocations() {
        do {
            let data = try Data(contentsOf: savePath)
            let locationsDecoded = try JSONDecoder().decode([Location].self, from: data)
            self.locations = locationsDecoded
        } catch {
            self.locations = []
        }
    }
    
    private init() { }
}
