//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Użytkownik Gość on 04/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["New York", "Berlin", "Moscow", "Dublin", "London", "Warsaw", "Paris", "Prague"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
    }
    
    func change_parameter(record: WeatherModel.WeatherRecord) {
        model.change_parameter(record: record)
    }
}
