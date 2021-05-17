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
        ScrollView(.vertical) {
            VStack {
                ForEach (viewModel.records) {record in
                    WeatherView(record: record, viewModel: viewModel)
                }
            }.padding()
        }
    }
}

struct WeatherView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke()
                    .frame(width: 320, height: 80)
                HStack {
                    GeometryReader { geometry in
                        Text("\(record.icon)").font(.system(size: geometry.size.height)).alignmentGuide(.leading, computeValue: { d in d[.leading] })}.frame(width: 40, height: 40)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(record.cityName)
                        if (record.viewed == 0) {
                            Text("Temperature: \(record.temperature, specifier: "%.1f")℃").font(.caption)
                        } else if (record.viewed == 1) {
                            Text("Humidity: \(record.humidity)%").font(.caption)
                        } else if (record.viewed == 2) {
                            Text("Wind speed: \(record.windspeed, specifier: "%.1f")kmph").font(.caption)
                        } else if (record.viewed == 3) {
                            Text("Wind direction: \(record.windDirection)°").font(.caption)
                        }
                    }
                    Spacer()
                    Text("↻").font(.largeTitle).onTapGesture {
                        viewModel.refresh(record: record)
                    }.alignmentGuide(.trailing, computeValue: {d in d[.trailing]})
                }.frame(width: 280, height: 40)
            }
            .onTapGesture {
                viewModel.change_parameter(record: record)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
