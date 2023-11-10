//
//  HomeViewModel.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import Foundation
import MapKit

extension HomeView {
    class HomeViewModel: ObservableObject {
        let manager: LocationManager
        
        @Published var locations: [Location]
        @Published var selectedPlace: Location?
        @MainActor @Published var currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -22.9035, longitude: -43.2096), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        func fetchLocations() {
            Task { @MainActor in
                await manager.fetchLocations()
                self.locations = await manager.locations
            }
        }
        
        func addNewLocation() {
            Task { @MainActor in
                await manager.addNewLocation(latitude: currentLocation.center.latitude, longitude: currentLocation.center.longitude)
                fetchLocations()
            }
        }
        
        func deleteLocation(location: Location) {
            Task { @MainActor in
                await manager.delete(location: location)
                fetchLocations()
            }
        }
        
        init() {
            self.manager = LocationManager(savePath: FileManager.documentyDirectory.appendingPathComponent("SavedPlace"))
            self.locations = []
            self.fetchLocations()
        }
    }
}
