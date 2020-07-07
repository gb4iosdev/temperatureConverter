//
//  ContentView.swift
//  temperatureConverter
//
//  Created by Gavin Butler on 06-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperatureValue: String = ""
    @State private var selectedInputIndex = 0
    @State private var selectedOutputIndex = 1
    
    private let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    private var convertedTemperature: String? {
        guard let temp = Double(temperatureValue) else { return nil }
        let measurement = Measurement(value: temp, unit: temperatureUnits[selectedInputIndex])
        let converted = measurement.converted(to: temperatureUnits[selectedOutputIndex])
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: converted.value))! + " \(converted.unit.symbol)"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Temperature", text: $temperatureValue)
                }
                Section(header: Text("Select Input Unit:")) {
                    Picker("", selection: $selectedInputIndex) {
                        ForEach(0..<temperatureUnits.count) {
                            Text(self.descriptionForUnit(self.temperatureUnits[$0]))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Select Output Unit:")) {
                    Picker("", selection: $selectedOutputIndex) {
                        ForEach(0..<temperatureUnits.count) {
                            Text(self.descriptionForUnit(self.temperatureUnits[$0]))
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Converted Temperature:")
                    .font(.headline)) {
                        Text("\(convertedTemperature ?? "")")
                }
            }.navigationBarTitle("Temperature Converter")
        }
    }
    
    func descriptionForUnit(_ unitType: UnitTemperature) -> String {
        switch unitType {
            case .celsius: return "Celcius"
            case .fahrenheit: return "Fahrenheit"
            case .kelvin: return "Kelvin"
            default: return "Unknown"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
