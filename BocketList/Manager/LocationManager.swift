//
//  LocationManager.swift
//  BocketList
//
//  Created by Isaque da Silva on 28/09/23.
//

import Foundation

actor LocationManager {
    var locations: [Location]
    let savePath: URL
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Falied to save data in FileManager. Error: \(error)")
        }
    }
    
    func fetchLocations() {
        do {
            let data = try Data(contentsOf: savePath)
            let locationsDecoded = try JSONDecoder().decode([Location].self, from: data)
            self.locations = locationsDecoded
        } catch let error {
            self.locations = []
            print("Error to fetch data from FileManager. Error: \(error)")
        }
    }
    
    func addNewLocation(latitude: Double, longitude: Double) {
        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: latitude, longitude: longitude)
        self.locations.append(newLocation)
        self.save()
    }
    
    func editedCurrentLocation(location: Location, name: String, description: String, onSave: @escaping () -> Void) {
        guard let selectedLocation = locations.firstIndex(of: location) else { return }
        
        locations[selectedLocation].name = name
        locations[selectedLocation].description = description
        self.save()
        onSave()
    }
    
    func delete(location: Location) {
        guard let selectedLocation = locations.firstIndex(of: location) else { return }
        locations.remove(at: selectedLocation)
        save()
    }
    
    init(savePath: URL) {
        self.locations = []
        self.savePath = savePath
    }
}
