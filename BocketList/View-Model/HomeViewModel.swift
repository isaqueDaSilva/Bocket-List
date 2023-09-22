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
        @Published var locations = [Location]()
        @Published var currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @Published var selectedPlace: Location?
        
        func addNewLocation() {
            DispatchQueue.main.async {
                let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: self.currentLocation.center.latitude, longitude: self.currentLocation.center.longitude)
                
                self.locations.append(newLocation)
            }
        }
    }
}
