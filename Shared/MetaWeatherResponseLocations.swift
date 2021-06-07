//
//  MetaWeatherResponseLocations.swift
//  WeatherApp
//
//  Created by AppleLab on 07/06/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let metaWeatherResponse = try? newJSONDecoder().decode(MetaWeatherResponse.self, from: jsonData)

import Foundation

// MARK: - MetaWeatherResponseElement
struct MetaWeatherResponseElement: Codable {
    let distance: Int
    let title: String
    let locationType: LocationType
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case distance, title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}

enum LocationType: String, Codable {
    case city = "City"
}

typealias MetaWeatherResponseLocations = [MetaWeatherResponseElement]
