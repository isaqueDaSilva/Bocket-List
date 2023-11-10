//
//  EditViewModel.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import Foundation

extension EditView {
    class EditViewModel: ObservableObject {
        let manager: LocationManager
        var location: Location
        var onSave: () -> Void
        
        @Published var name: String
        @Published var description: String
        @Published var loadingState: LoadingState = .loading
        @Published var pages = [Page]()
        
        func save() {
            Task { @MainActor in
                await manager.editedCurrentLocation(location: location, name: name, description: description, onSave: onSave)
            }
        }
        
        func fetchNearbyPlaces() {
            Task {
                let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
                
                guard let url = URL(string: urlString) else {
                    print("Bad URL: \(urlString)")
                    return
                }
                
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        print("Bad response!")
                        throw Errors.invalidResponse
                    }
                    
                    let dataDecode = try JSONDecoder().decode(Result.self, from: data)
                    pages = dataDecode.query.pages.values.sorted()
                    self.loadingState = .loaded
                } catch let error {
                    print("Error to fetch data \(error).")
                    loadingState = .failed
                }
            }
        }
        
        init(manager: LocationManager, location: Location, onSave: @escaping () -> Void) {
            self.manager = manager
            self.location = location
            self.onSave = onSave

            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
            
            self.fetchNearbyPlaces()
        }
    }
}
