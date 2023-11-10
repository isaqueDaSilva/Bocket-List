//
//  HomeView.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import MapKit
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.currentLocation, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack(alignment: .center) {
                        Marker(color: .red)
                            .padding()
                            .background(.white.opacity(0.75))
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    }
                    .padding()
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                    .contextMenu {
                        Button {
                            viewModel.deleteLocation(location: location)
                        } label: {
                            HStack {
                                Text("Delete \(location.name)")
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            
            Marker(color: .blue)
            
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        viewModel.addNewLocation()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(manager: viewModel.manager, location: place) { viewModel.fetchLocations() }
        }
    }
}
