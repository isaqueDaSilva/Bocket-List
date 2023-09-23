//
//  HomeViewModel.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import Foundation
import MapKit

extension HomeView {
    @MainActor 
    class HomeViewModel: ObservableObject {
        @Published private(set) var locations: [Location]
        @Published var currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -22.9035, longitude: -43.2096), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        @Published var selectedPlace: Location?
        
        let savePath = FileManager.documentyDirectory.appendingPathComponent("SavedPlace")
        
        func addNewLocation() {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: currentLocation.center.latitude, longitude: currentLocation.center.longitude)
            self.locations.append(newLocation)
            self.save()
        }
        
        func updateLocation(_ location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = self.locations.firstIndex(of: selectedPlace) {
                self.locations[index] = location
                self.save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(self.locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch let error {
                print("Falied to save data in FileManager. Error: \(error)")
            }
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                self.locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                self.locations = []
            }
        }
    }
}
