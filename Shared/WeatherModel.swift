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
    var currCity: WeatherRecord? = nil
    
    init(cities: [String: String]) {
        records = Array<WeatherRecord>()
        for (city, id) in cities {
            records.append(WeatherRecord(weatherId: id, cityName: city))
        }
    }
    
    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var weatherId: String
        var cords: String = "0.0,0.0"
        var cityName: String
        var temperature: Float = Float.random(in: -10.0...30.0)
        var humidity: Int = Int.random(in: 0...100)
        var windspeed: Float = Float.random(in: 0.0...20.0)
        var windDirection: Int = Int.random(in: 0..<360)
        var viewed: Int = 0
        var weatherStateName: String = ""
        var weatherStateAbbr: String = ""
        var iconUrl: String = ""
    }
    
    
    
    mutating func refresh(record: WeatherRecord, val: MetaWeatherResponse) {
        for i in 0..<records.count {
            if (records[i].id == record.id) {
                records[i].weatherStateName = val.consolidatedWeather[0].weatherStateName
                records[i].weatherStateAbbr = val.consolidatedWeather[0].weatherStateAbbr
                records[i].temperature = Float(val.consolidatedWeather[0].theTemp)
                records[i].humidity = Int(val.consolidatedWeather[0].humidity)
                records[i].windspeed = Float(val.consolidatedWeather[0].windSpeed)
                records[i].windDirection = Int(Float(val.consolidatedWeather[0].windDirection))
                records[i].cords = val.lattLong
                records[i].iconUrl = "https://www.metaweather.com/static/img/weather/png/64/\(records[i].weatherStateAbbr).png"
            }
        }
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
