//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Użytkownik Gość on 04/05/2021.
//

import Foundation

let status = ["Clear", "Snow", "Light Rain", "Heavy Rain", "Light Cloud", "Heavy Cloud"]
let icons = ["☀️", "🌨", "🌦", "🌧", "🌤", "☁️"]


struct WeatherModel {
    
    var records: Array<WeatherRecord>
    
    init(cities: Array<String>) {
        records = Array<WeatherRecord>()
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
        setIcons()
    }
    
    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var cityName: String
        var weatherStatusCode: Int = Int.random(in: 0...5)
        var temperature: Float = Float.random(in: -10.0...30.0)
        var humidity: Int = Int.random(in: 0...100)
        var windspeed: Float = Float.random(in: 0.0...20.0)
        var windDirection: Int = Int.random(in: 0..<360)
        var viewed: Int = 0
        var weatherStatus: String = ""
        var icon: String = ""
    }
    
    mutating func setIcons(){
        for i in 0..<records.count {
            records[i].weatherStatus = status[records[i].weatherStatusCode]
            records[i].icon = icons[records[i].weatherStatusCode]
        }
    }
    
    mutating func refresh(record: WeatherRecord) {
        for i in 0..<records.count {
            if (records[i].id == record.id) {
                records[i].weatherStatusCode = Int.random(in: 0...5)
                records[i].temperature = Float.random(in: -10.0...30.0)
                records[i].humidity = Int.random(in: 0...100)
                records[i].windspeed = Float.random(in: 0.0...20.0)
                records[i].windDirection = Int.random(in: 0..<360)
            }
        }
        setIcons()
        print("refreshing city: \(record.cityName)")
    }
    
    mutating func change_parameter(record: WeatherRecord) {
        print("changing display for: \(record.cityName)")
        for i in 0..<records.count {
            if (records[i].id == record.id) {
                records[i].viewed += 1
                if (records[i].viewed > 3) {
                    records[i].viewed = 0
                }
            }
        }
    }
    
}
