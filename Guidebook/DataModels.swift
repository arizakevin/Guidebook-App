//
//  City.swift
//  Guidebook
//
//  Created by Kevin Ariza on 5/09/23.
//

import Foundation

import Foundation

struct City: Identifiable, Decodable {
    let id: UUID = UUID()
    let name: String
    let summary: String
    let imageName: String
    let attractions: [Attraction]
}

struct Attraction: Identifiable, Decodable {
    let id: UUID = UUID()
    let name: String
    let summary: String
    let longDescription: String
    let imageName: String
    let latLong: String
}


