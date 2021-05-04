//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Użytkownik Gość on 04/05/2021.
//

import Foundation

struct WeatherModel {
    
    var records: Array<WeatherRecord>
    
    init(cities: Array<String>) {
        records = Array<WeatherRecord>()
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
    }
    
    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var cityName: String
        var weatherStatus: String = "Clear"
        var temperature: Float = Float.random(in: -10.0...30.0)
        var humidity: Int = Int.random(in: 0...100)
        var windspeed: Float = Float.random(in: 0.0...20.0)
        var windDirection: Int = Int.random(in: 0..<360)
    }
    
    mutating func refresh(record: WeatherRecord) {
        records[0].temperature = Float.random(in: -10.0...30.0)
        records[0].humidity = Int.random(in: 0...100)
        records[0].windspeed = Float.random(in: 0.0...20.0)
        records[0].windDirection = Int.random(in: 0..<360)
        print("refreshing city: \(record.cityName)")
    }
}
