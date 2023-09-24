//
//  EditViewModel.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import Foundation

extension EditView {
    @MainActor class EditViewModel: ObservableObject {
        @Published var name: String
        @Published var description: String
        @Published var loadingState: LoadingState = .loading
        @Published var pages = [Page]()
        
        var location: Location
        var onSave: (Location) -> Void
        
        func save() {
            var editedLocation = self.location
            editedLocation.id = UUID()
            editedLocation.name = self.name
            editedLocation.description = self.description
            Task { @MainActor in
                self.onSave(editedLocation)
            }
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Bad response!")
                    throw Erros.invalidResponse
                }
                
                let dataDecode = try JSONDecoder().decode(Result.self, from: data)
                pages = dataDecode.query.pages.values.sorted()
                DispatchQueue.main.async {
                    self.loadingState = .loaded
                }
            } catch let error {
                print("Error to fetch data \(error).")
                loadingState = .failed
            }
        }
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
    }
}
