//
//  FileManager.swift
//  BocketList
//
//  Created by Isaque da Silva on 22/09/23.
//

import Foundation

extension FileManager {
    static var documentyDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
