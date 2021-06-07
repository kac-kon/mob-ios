//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Użytkownik Gość on 04/05/2021.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["New York": "2459115", "Berlin": "638242", "Moscow": "2122265", "Dublin": "560743", "London": "44418", "Warsaw": "523920", "Paris": "615702", "Prague": "796597"])
    
    private let fetcher: MetaWeatherFetcher
    var cityName = ""
    
    private var cancellables: Set<AnyCancellable> = []
    private let locationManager: CLLocationManager
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    override init() {
        fetcher = MetaWeatherFetcher()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        for i in records{
            fetcherWeather(record: i)
        }
    }
    
    func fetcherWeather(record: WeatherModel.WeatherRecord) {
        fetcher.forecast(forId: record.weatherId)
            .sink(receiveCompletion: {completion in
                print(record.cityName)
                print(completion)
            }, receiveValue: {value in
                print(value.consolidatedWeather[0].theTemp)
                self.model.refresh(record: record, val: value)
            })
            .store(in: &cancellables)
    }
    
    func fetcherLocations(lat: String, long: String, name: String) {
        fetcher.findCity(lat: lat, long: long)
            .sink(receiveCompletion: {completion in
                print(completion)
            }, receiveValue: {value in
                let current = value[0]
                self.model.currCity = WeatherModel.WeatherRecord(weatherId: String(current.woeid), cords: current.lattLong, cityName: String(current.title + "(" + name + ")"))
                self.model.records.insert(self.model.currCity!, at:0)
                self.fetcherWeather(record: self.model.currCity!)
            })
            .store(in: &cancellables)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation? = locations.last
        let geocoder = CLGeocoder()
        var currCity: String = ""
        geocoder.reverseGeocodeLocation(currentLocation!) {
            placemarks, error in
            self.cityName = placemarks?[0].locality ?? ""
            currCity = placemarks?[0].locality ?? ""
            print("City \(currCity)")
            self.fetcherLocations(lat: String(currentLocation?.coordinate.latitude ?? 0.0), long: String(currentLocation?.coordinate.longitude ?? 0.0), name: currCity)
        }
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
        fetcherWeather(record: record)
    }
    
    func change_parameter(record: WeatherModel.WeatherRecord) {
        model.change_parameter(record: record)
    }
}
