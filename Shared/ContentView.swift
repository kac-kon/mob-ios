//
//  ContentView.swift
//  Shared
//
//  Created by Użytkownik Gość on 04/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            ForEach (viewModel.records) {record in
                WeatherView(record: record, viewModel: viewModel)
            }
        }.padding()
    }
}

struct WeatherView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke()
            HStack {
                Text("☀️").font(.largeTitle)
                VStack {
                    Text(record.cityName)
                    Text("Temperature: \(record.temperature, specifier: "%.1f")℃").font(.caption)
                }
                Text("↻").font(.largeTitle).onTapGesture {
                    viewModel.refresh(record: record)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
