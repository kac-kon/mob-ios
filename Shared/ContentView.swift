//
//  ContentView.swift
//  Shared
//
//  Created by Użytkownik Gość on 04/05/2021.
//

import SwiftUI
import Foundation
import MapKit

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

struct Place: Identifiable {
    let id = UUID()
    let cords: CLLocationCoordinate2D
}

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var region: MKCoordinateRegion
    @State var place: Array<Place>
    var body: some View {
        VStack {
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            Map(coordinateRegion:  $region, annotationItems: place) {place in
                MapPin(coordinate: place.cords)
            }
        }
    }
}

struct WeatherView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    @State var showingSheet = false
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke()
                    .frame(width: 320, height: 80)
                HStack {
                  //  let data = try? Data(contentsOf: record.iconUrl)
                  //  GeometryReader { geometry in
                      //  Image(uiImage: UIImage(data: data!))
                        //    .alignmentGuide(.leading, computeValue: { d in //d[.leading] })}.frame(width: 40, height: 40)
                    //Spacer()
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
                    }
                    //.alignmentGuide(.trailing, computeValue: {d in d[.trailing]})
                    Text("S")
                        .onTapGesture {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        let region = getRegion()
                        let place_ = getPlace()
                        MapView(region: region, place: [place_])
                    }
                }.frame(width: 280, height: 40)
            }
            .onTapGesture {
                viewModel.change_parameter(record: record)
            }
    }
    
    func getRegion() -> MKCoordinateRegion{
        let cords = record.cords.components(separatedBy: ",")
        let lat = Double(cords[0]) ?? 0.0
        let long = Double(cords[1]) ?? 0.0
        let center = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        let region = MKCoordinateRegion(
            center: center,
            span: span)
        return region
        }
    func getPlace() -> Place {
        let cords = record.cords.components(separatedBy: ",")
        print(cords)
        return Place(cords: .init(latitude: Double(cords[0]) ?? 0.0, longitude: Double(cords[1]) ?? 0.0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
