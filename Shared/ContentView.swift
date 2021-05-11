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
                    Text("☀️").font(.largeTitle).alignmentGuide(.leading, computeValue: { d in d[.leading] })
                    VStack(alignment: .leading) {
                        Text(record.cityName)
                        Text("Temperature: \(record.temperature, specifier: "%.1f")℃").font(.caption)
                    }
                    Text("↻").font(.largeTitle).onTapGesture {
                        viewModel.refresh(record: record)
                    }.alignmentGuide(.trailing, computeValue: {d in d[.trailing]})
                }.frame(width: 300)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
