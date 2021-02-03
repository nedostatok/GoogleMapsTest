//
//  PlacesModel.swift
//  MapKitTest
//
//  Created by User on 21.01.2021.
//

import Foundation

struct Places: Decodable {
    let places: [Place]
}

struct Place: Decodable {
    let id: Int
    let name: String
    let lat: Double
    let lng: Double
}
