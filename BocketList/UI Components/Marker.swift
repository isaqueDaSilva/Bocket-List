//
//  Marker.swift
//  BocketList
//
//  Created by Isaque da Silva on 21/09/23.
//

import SwiftUI

struct Marker: View {
    let color: Color
    var body: some View {
        Image(systemName: "mappin")
            .font(.system(size: 35))
            .foregroundColor(color)
            .frame(width: 32, height: 32)
    }
}
