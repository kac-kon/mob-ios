//
//  MetaWeatherFetcher.swift
//  WeatherApp
//
//  Created by AppleLab on 07/06/2021.
//

import Foundation
import Combine

class MetaWeatherFetcher{
    
    func forecast(forId: String) -> AnyPublisher<MetaWeatherResponse, Error> {
        let url = URL(string: "https://www.metaweather.com/api/location/\(forId)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: MetaWeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func findCity(lat: String, long: String) -> AnyPublisher<MetaWeatherResponseLocations, Error> {
        let url = URL(string: "https://www.metaweather.com/api/location/search/?lattlong=\(lat),\(long)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: MetaWeatherResponseLocations.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
