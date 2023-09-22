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
        NavigationView {
            ZStack {
                Map(coordinateRegion: $viewModel.currentLocation, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Marker(color: .red)
                                .padding()
                                .background(.white.opacity(0.75))
                                .clipShape(Circle())
                                .padding(.trailing)
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
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
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { viewModel.updateLocation($0) }
            }
        }
    }
}
