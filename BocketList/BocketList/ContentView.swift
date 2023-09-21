//
//  ContentView.swift
//  BocketList
//
//  Created by Isaque da Silva on 18/09/23.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion).ignoresSafeArea()
            
            Image(systemName: "mappin")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 44, height: 44)
        }
    }
}
