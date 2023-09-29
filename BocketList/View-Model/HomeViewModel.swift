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
        let manager = LocationManager.shared
        
        @Published var locations = [Location]()
        @Published var currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -22.9035, longitude: -43.2096), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        @Published var selectedPlace: Location?
        
        func addNewLocation() {
            Task {
                await manager.addNewLocation(latitude: currentLocation.center.latitude, longitude: currentLocation.center.longitude)
            }
            getLocations()
        }
        
        func updateLocation(_ location: Location) {
            Task {
                await manager.updateLocation(selectedPlace: selectedPlace, location)
            }
            getLocations()
        }
        
        func save() {
            Task {
                await manager.save()
            }
            getLocations()
        }
        
        func decodeLocations() {
            Task {
                await manager.decodeLocations()
            }
            getLocations()
        }
        
        func getLocations() {
            Task {
                self.locations = await manager.locations
            }
        }
        
        init() {
            self.decodeLocations()
            self.getLocations()
        }
    }
}
